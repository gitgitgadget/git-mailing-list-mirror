From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported
 commit
Date: Fri, 2 Jul 2010 00:12:01 -0500
Message-ID: <20100702051201.GC7209@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 07:12:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUYYM-0004Ml-LI
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 07:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab0GBFMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 01:12:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41731 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab0GBFM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 01:12:29 -0400
Received: by iwn7 with SMTP id 7so2840958iwn.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 22:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0Ovpfes7+JDy1V4kWihRKHbnbipOQRoDS7SHkhCcE78=;
        b=ui5iKKkBrMLpHyhzTXm+qrVQ9ibzajBOu9W3UGB2AoJ4ytW+Fmzs/Smre6nnFZHZWV
         NOpOuoC4jkD7IauxoSAGbzC7llVDMyu5Mk1lg3YGceLVATC1LLc+5e3sYpS99ArbKG3u
         89l7ZqwqPmLULby6PVJPrt/fw/khRpyOvRGgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kKCBqlz8fzExMetEG2oFMsWm1xiZoSw+GLC6tWYGOak3ZcdXD9ieJX+Gg7DE1KeSOc
         ZIaj7Cj/678Wq0TFS22XKbnLzfj+EJkSWIyPSkq4Ni8+kOhmY/Kc78zCc+7HWZc5LtuB
         LPNmlaSzqxZUZ1WS7sar1WtBmje0n2HD2j5cg=
Received: by 10.231.174.136 with SMTP id t8mr227223ibz.158.1278047547959;
        Thu, 01 Jul 2010 22:12:27 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm1222648ibk.15.2010.07.01.22.12.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 22:12:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100701054849.GA14972@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150107>

Jonathan Nieder wrote:

> Should fast-import accept lines of the form
>=20
>  M 100644 <commit id>:<path> <path>
>=20
> and
>=20
>  M 040000 <commit id>:<path> <path>
>=20
> to allow the caller to use commits before they are accessible
> through the git object database?

A =E2=80=98cat=E2=80=99 command (suggested by David) would also be usef=
ul, so the
caller can read trees and blobs before they are accessible through
the object db.  The svn importer would use this when applying
(svndiff0-format) deltas to import changes to regular files.
