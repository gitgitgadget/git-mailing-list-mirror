From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: notes TODOs
Date: Sun, 7 Feb 2010 20:05:04 +0100
Message-ID: <201002072005.05832.jnareb@gmail.com>
References: <cb7bb73a1002050444y55f57696gb1b3bd06ab9261ac@mail.gmail.com> <m3aavma9gg.fsf@localhost.localdomain> <7vr5oy2qh3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 20:05:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeCRb-0005xC-DQ
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 20:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932957Ab0BGTFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 14:05:12 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47180 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab0BGTFL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 14:05:11 -0500
Received: by bwz19 with SMTP id 19so1278375bwz.28
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 11:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=I9KrbUXfKfbuTwmpOGq5lnh/EUJtStf4ImQIEZFHh3Q=;
        b=LeE0EdJvueuBHrFTChCWiGCKN6D2RZ6BdccFOQUrY4X+au8tkuIWOh3ypHQp44MQAj
         XBL7HjBgeSHVY1MaOplIj4woHIqhRNIB8EDK0bQeyezgWxSDzUSTENb2/ZMEDAcKWcEq
         98xt7tQyAgjhuTlIldKUpj/39y9zPUz6GwB3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CSxWL/qBUI9druCNBiZClMoKbQEpVVuBhjY/nEX1Bbq4XUoEVqHj10ZmpJaPMoUgXz
         R0EPXc1QsowmFQCDOkZfNZudfolLC2r0hzxNbNn4hiokH7o9ZkksfREVvz2okHExvnQL
         cACfa3tzo+DHYkFot+vpJ8NHD2tmEIVAcLUUQ=
Received: by 10.204.18.212 with SMTP id x20mr4653bka.9.1265569509148;
        Sun, 07 Feb 2010 11:05:09 -0800 (PST)
Received: from ?192.168.1.13? (abvv164.neoplus.adsl.tpnet.pl [83.8.219.164])
        by mx.google.com with ESMTPS id 15sm1554408bwz.0.2010.02.07.11.05.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 11:05:06 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr5oy2qh3.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139247>

On Sat, 6 Feb 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> >   'git notes' move [-f] <oldobject> <newobject>
> 
> I suspect "copy" to keep the old one than "move" would be a lot more
> sensible, especially when you are talking about people (like me) who amend
> often.  They cannot get it right in their first try by definition ;-), and
> their very original edition is sometimes easier to start from than their
> second edition, when they are trying to come up with the final edition of
> the commit.  Using "move" to lose the notes from the old object will make
> it harder to go back to the original and start amending from there.

True.  It would be better then to have "git notes copy ...", and perhaps
even a configuration option to have --amend copy notes to new version
automatically.

You can always get note before move with

  GIT_NOTES_REF=refs/notes/commit^ <git command>

(assuming that you use default notes ref).  But that would work for
"git show", but not for "git log --walk-reflogs".


P.S. I have tried to use 'git notes edit v1.6.6.1', and while it annotates
a tag object, the message in editor make it look like you are annotating
the commit it points to.

-- 
Jakub Narebski
Poland
