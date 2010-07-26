From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list
 available repositories
Date: Mon, 26 Jul 2010 18:28:55 -0500
Message-ID: <20100726232855.GA3157@burratino>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
 <AANLkTin+EMYHrr11Dba9Mob+b_Dar_cedWmTsDF=AHFt@mail.gmail.com>
 <AANLkTilSqePFPkteFd7DBgmdhqJHfUDuW_qhkbWVVb3Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Brockman <gdb@mit.edu>, j.sixt@viscovery.net,
	gitster@pobox.com, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 01:30:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdX86-0001e5-Sj
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 01:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab0GZXaJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 19:30:09 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63852 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab0GZXaE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 19:30:04 -0400
Received: by gxk23 with SMTP id 23so1048129gxk.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zSAXBUg5AvlZceYG6nGyx3LJzBWPeMbpPPBLfLL33fM=;
        b=D/2UIl1OIxbMLkWcWWTH5ABMkuGH15C4hNyf1QooNMJ++Bn0SONA3fNbj21pt0+ipL
         Yxgz8i4oCWmMsCdFTgE6FhSObW9gpzhRmCo+evwHpg9ILuYBn77ljE9iu+r9mTjyKx1P
         ULMDy18vJdDMCKtsaRyc9faD4YIqrCYfJ9Bng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LZy64Y2rOfC9vgAGdc1E2G2BFfyWFkgSlm97DQfBrEstp8FeTg5GAz6iI4dSspdRGB
         x8MwRVyxIRru66g0WGITRFHrmuY9nQxgxJejjvDa3GNfdJEb5fuFYL8kCYDo58jGs9a4
         cs4VJyXBQE952qHAsLPqJgAkQCIp9m+5/e+0w=
Received: by 10.150.97.4 with SMTP id u4mr2284502ybb.51.1280187004309;
        Mon, 26 Jul 2010 16:30:04 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u41sm2577386yba.13.2010.07.26.16.30.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 16:30:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilSqePFPkteFd7DBgmdhqJHfUDuW_qhkbWVVb3Y@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151904>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Jul 26, 2010 at 22:32, Greg Brockman <gdb@mit.edu> wrote:

>> Just sending a reminder about this patch series--I haven't seen any
>> comments on it yet, so I assume it's gotten lost in the flurry of
>> other list activity.
>
> It would probably help if you re-send the entire thing again.

Wait wait, it=E2=80=99s only been about five days!

I mean, you are free to re-send, but it is probably better to
send a link to the gmane archive, like this:

 http://thread.gmane.org/gmane.comp.version-control.git/151398

so people can catch up with the earlier discussion.

In this case, I am nervous about the impact for existing installations
with git-shell deployed.  If a person can smuggle in an unpleasant
git-shell-commands directory somehow, the effect would not be good.
Maybe there should be a way to disable this feature systemwide for the
paranoid (or maybe not; I=E2=80=99m only vaguely worried).

Patch 1 still uses execv(), which is not available on Windows.

Have you tried out these patches "in the wild"?  If so, that would be
interesting to hear about.

Jonathan
