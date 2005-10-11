From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Cleaning up die() error messages
Date: Tue, 11 Oct 2005 17:02:11 +0200
Message-ID: <81b0412b0510110802lbcdebe0m17bce7ca81ea76d2@mail.gmail.com>
References: <20051010105008.GB30202@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 17:03:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPLdw-0003D5-9b
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 17:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVJKPCN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 11:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVJKPCN
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 11:02:13 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:59441 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932124AbVJKPCM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 11:02:12 -0400
Received: by nproxy.gmail.com with SMTP id a4so582790nfc
        for <git@vger.kernel.org>; Tue, 11 Oct 2005 08:02:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b5sLTB+NsZLikiESicL0aUQg0S2US8lJeiYQLMPlVTyTv+BkcWdVI5R+XyBdqiU8UEm7XEQZ/J4z+Y86jVfHv7/ASpkahmwIr4t7onJi6pfrAgFYoegjne+QJnst3xKiRA6u4AomCxo6m0L1vhVjK1NqnoklZKgJrxC2VvlYi+E=
Received: by 10.49.5.11 with SMTP id h11mr376880nfi;
        Tue, 11 Oct 2005 08:02:11 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Tue, 11 Oct 2005 08:02:11 -0700 (PDT)
To: Elfyn McBratney <beu@gentoo.org>
In-Reply-To: <20051010105008.GB30202@gentoo.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9969>

On 10/10/05, Elfyn McBratney <beu@gentoo.org> wrote:
>         int main (int argc, char **argv)
>         {
>                 set_prog_name(argv[0]);

I'd also use readlink on /proc/self/exe by default (if set_prog_name
_not_ called).
It simplifies the code at least on linux, and makes possible very slow
transition for other platforms. So you don't have to update each and
every .c file containing "main[[:space:]]*(" ;)
