From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] New type of remote helpers
Date: Sun, 3 Oct 2010 10:13:04 -0500
Message-ID: <20101003151304.GH17084@burratino>
References: <4CA86A12.6080905@dbservice.com>
 <AANLkTikQyVLyH-O-OH2yZ0B3_UKDqzcnNgtqefSCN68t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Carnecky <tom@dbservice.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 17:16:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2QIa-0003pX-8j
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 17:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab0JCPQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 11:16:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55834 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab0JCPQS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 11:16:18 -0400
Received: by iwn5 with SMTP id 5so5841534iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kcfrNJ69ElZt9jtYDRGT8sEWbuZSB1gv6SjnQlpO28o=;
        b=oYcHpdvZq0YA061BzMSAuNsT5pWAnbzUZzirBsa0ffu+rsRAEhT4f67Jgj2wfobrFO
         k3aiW5vtydwAR5TRwIMB55by39qqgeHDHJSEhy3GGGivK24R5TDmakM3z6Enj8JOmjp5
         cOoDXxnWguB5AfvSPI/CQoCd4i10aIgdRT30k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oIwex177S8Od5cfpmLUtF5e3vBUD3yrtdpioBj1LqMYorLc3W/hKyIj7MTjFGa5zkN
         GNlewZOyI+j9AVzHD3EZLDY/RzjQDhGt8yQXjtS0replRteYTBx09M+2DKOnheNnPBGT
         H8OwCPx50SHQ6J0kY8uaps/u2jElodO3CMnCM=
Received: by 10.231.13.201 with SMTP id d9mr6156241iba.152.1286118977781;
        Sun, 03 Oct 2010 08:16:17 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id g31sm3804973ibh.10.2010.10.03.08.16.16
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 08:16:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikQyVLyH-O-OH2yZ0B3_UKDqzcnNgtqefSCN68t@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157881>

Hi,

Sverre Rabbelier wrote:
> On Sun, Oct 3, 2010 at 13:33, Tomas Carnecky <tom@dbservice.com> wrote:

>> To test this
>> approach I created a simple remote helper for svn.
>
> I guess it suffices as a POC, but I'd have preferred to see
> collaboration with the people working on git-remote-svn instead
> (cc-ed).

Just a quick note: if this approach gets a working remote helper
in the hands of users faster, I'm all for it.

My only concern is the name: if it is not compatible the planned
remote helper from the summer of code project, they should probably
get different names.  Correct me if I'm wrong, but the main
differences are:

 - this is scripted and uses local svn working copy operations; the
   soc project is in C and uses remote access ("replay")

 - this uses the nice ls-remote output etc.  Ram, do you think this
   would be easy to use for remote-svn?

So, not many differences.  Maybe we can standardize the interface
and consider them alternate implementations?
