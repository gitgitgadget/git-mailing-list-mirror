From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/13] fast-import: add the 'done' command
Date: Sun, 29 Aug 2010 16:24:20 -0500
Message-ID: <20100829212419.GC1890@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 23:26:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OppOJ-0001y5-M3
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 23:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab0H2V0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 17:26:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35616 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab0H2V0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 17:26:09 -0400
Received: by gwj17 with SMTP id 17so1769909gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4G7GLwBF3UES1LOXOt8tckzJtVgt9c9pZ+cNFWJoIkk=;
        b=xJBS0JI0bu2+uAHtR3Ygu3r+JG4rZICOzJe/LKVRXJh2g2fLDJogYnSQ0ajEOppELW
         sC6loJvZoZjS/sFiLVm3nfzMvSf48vt7oGZkMuOPflPFU6z4LzNvgm4KnpDBG2+LX7t/
         7HRfy/DPROKa0e0JmDqlzqKUA6gd7/3vx/d3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=J7eMhKhBF64O4DiRWXYqLY2b3ZZEe3QLtmFYuNwSyzVPf4OHwXsfl/KFd1aRkWO+fA
         yg0czsBStBRgIK8LqGbudicabkOkZfWltY/rjKxsq9b8HKJdmKBfr/5uDjtj8K3JEhQL
         RwzrqyzxHtKPNxO7jDPtsJpd6zrK5n6atxgkM=
Received: by 10.90.73.10 with SMTP id v10mr2953455aga.94.1283117168433;
        Sun, 29 Aug 2010 14:26:08 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm6599048ibk.15.2010.08.29.14.26.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 14:26:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283053540-27042-2-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154718>

Sverre Rabbelier wrote:

> Add a trivial 'done' command that causes fast-import to stop reading
> from the stream and exit.

I like it.  

It is tempting to make the 'done' command mandatory when the "done"
feature is used, to prevent confusion from streams that are cut off
early.  What do frontends currently do to handle that?
