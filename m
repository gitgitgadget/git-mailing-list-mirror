From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv2 1/2] gitweb: add patch view
Date: Wed, 3 Dec 2008 21:52:00 +0100
Message-ID: <cb7bb73a0812031252t7f88cedfic266c218f707cee7@mail.gmail.com>
References: <1228298862-28191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200812031400.50980.jnareb@gmail.com>
	 <cb7bb73a0812030514u11e10bebue5a1451d54fc3f96@mail.gmail.com>
	 <200812031808.01916.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:53:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7yiw-0000DP-9f
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 21:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbYLCUwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 15:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbYLCUwF
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 15:52:05 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:2571 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYLCUwC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 15:52:02 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1588739eyi.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 12:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dDp2W6n8vjeo2ID/K1ifX2d63evRBoLf5WDa+ktwMcM=;
        b=P8Kxj3/mIYvHiVk+LBrfR/+25gvW8Gg+pbRgUmzaocn1RJ/hgsvnSQZGNDnXDn+K8L
         soCTUQuD82hXOAsnBcQVUlbXIrIgjydZ5aOlEHWbQ9AotSwdmHNuMEp6HBb2aHGoWeJX
         LDU056pvNJUJMRfS8QytRYjX/o/37IcEaObGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PynTxgJS4ujf6bBhvKg/xCPVmgni5Mmpn2ci2PhO1YrBkd+GAUXhYSgM+/Z+XLpI+Q
         ACt4flK/+xqygswTICVrKWmPo1rHWYNdONFXYPzKu/Waj4Sl8CIrNe8SV6X0zhG4gNFZ
         I5Tc/bGTWEnYyqhkue5pYzyjEALv869IgP70g=
Received: by 10.210.38.13 with SMTP id l13mr9905439ebl.3.1228337521043;
        Wed, 03 Dec 2008 12:52:01 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Wed, 3 Dec 2008 12:52:00 -0800 (PST)
In-Reply-To: <200812031808.01916.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102286>

On Wed, Dec 3, 2008 at 6:08 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, Dec 3, 2008 at 14:14, Giuseppe Bilotta wrote:
>>
>> The way it's implemented in v2, you just need to set $patch_max in
>> your local or system config file (e.g. /etc/gitweb.conf). I'm not sure
>> about the benefit we would gain in going through %feature.
>
> Ah, I haven't read patch in detail yet.
>
> The (doubtful or not) benefit of going through %feature would be ability
> to set limits (with perhaps -1 / <0 / undef / '' meaning: unlimited) on
> per repository basis, with no limit for small repository, some limit for
> the rest, and no 'patch' view or heavily limited for repository with
> large size commits.

Hm. I'm not entirely sure it would be used at all, but I think this
could be done. Something like the following:
 * perl false meaning: feature disabled
 * > 0 maximum number of patches
 * does Perl have an 'infinity' value? if not, we can use <0 to mean unlimited

-- 
Giuseppe "Oblomov" Bilotta
