From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GPG signing for git commit?
Date: Mon, 11 May 2009 20:39:38 +1000
Message-ID: <fcaeb9bf0905110339q22692751jc12f5a199bf47740@mail.gmail.com>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain> 
	<49D99BB2.2090906@vilain.net> <20090415185554.GG23644@curie-int> 
	<fcaeb9bf0905062230h7ba9526fg6b79ddade72c072a@mail.gmail.com> 
	<robbat2.20090508T190254.538956494Z@orbis-terrarum.net> <fcaeb9bf0905101553p56f5e8b2o6e6b550e9494b726@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016368e1d8a89b88d0469a099de
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon May 11 12:40:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Svb-0005fg-MG
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 12:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbZEKKkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 06:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbZEKKkA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 06:40:00 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:43484 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbZEKKj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 06:39:59 -0400
Received: by an-out-0708.google.com with SMTP id d40so9737772and.1
        for <git@vger.kernel.org>; Mon, 11 May 2009 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=fRX67qsqCXYHhUXUeYCEW7Gpx6T9uoHfypExWYrV3jY=;
        b=jPYMoYwaG0HsJqiSDN9+d8aFaDIa1xG5ZLZJd5H6cVU3JxgBuViV5hHvvX3u/6RAuo
         mLoVw/JR8RRlWRvN17QnTYEwcYnIifxV35TlTkT6a3bmzmV0GKXadQuj6d30FdReUb/U
         q4BD5+PAXsKsg6MP07bQLORKBG/8+r8wxG6D8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Nyju1Xl5nxDsNCVibTT074pmwaH3dRGOOJXXAaNPgV+WmpteSEMqJg86p6lNgPyxmx
         8v/3EVHvp/SNVbMMPYeio/CFNAhRgKkqNRfvxA46B53avrrQAhp2rJXtoHXTSDUvJ/SL
         zH8t8u4vhaxMvVszW/lqiNN/dLa4xtfn/t5+8=
Received: by 10.101.67.11 with SMTP id u11mr16982961ank.73.1242038398464; Mon, 
	11 May 2009 03:39:58 -0700 (PDT)
In-Reply-To: <fcaeb9bf0905101553p56f5e8b2o6e6b550e9494b726@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118788>

--0016368e1d8a89b88d0469a099de
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, May 11, 2009 at 8:53 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Sat, May 9, 2009 at 5:03 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
>>> How about signing the tree SHA-1 and putting the signature in commit
>>> message? It's like gpg way of saying Signed-off-by. If the committer
>>> wants to sign again before pushing out, he could amend the commit,
>>> append his signature there; or make a no-change commit to contain his
>>> signature (probably from git-commit-tree because iirc git-commit won't
>>> let you make no-change commit)
>> Hmm, I like the sound of that, but I'm concerned it might be difficult
>> to enforce. If rewrite-history ever happens, it's also invalidated.
>
> Well if you rewrite and touch the trees, then every signature should
> be invalidated anyway. If you only touch commit message, it should
> remain valid because I only sign trees.

I went ahead and made two scripts git-gpg-sign and git-gpg-verify to
see if it works. Things that are signed in these scripts:
 - tree
 - parents
 - any other gpg signature
You probably don't want to sign the same commit too many times because
the signature will get huge.
-- 
Duy

--0016368e1d8a89b88d0469a099de
Content-Type: application/octet-stream; name=git-gpg-sign
Content-Disposition: attachment; filename=git-gpg-sign
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ful1frqa0

IyEvYmluL3NoClBHUD0nL14tLS0tLUJFR0lOIFBHUCBNRVNTQUdFLS0tLS0kLywvXi0tLS0tRU5E
IFBHUCBNRVNTQUdFLS0tLS0kLycKQ09NTUlUX0dQR01TRz0iJChnaXQgcmV2LXBhcnNlIC0tZ2l0
LWRpcikiL0NPTU1JVF9HUEdNU0cKR1BHTVNHPSIkKGdpdCByZXYtcGFyc2UgLS1naXQtZGlyKSIv
R1BHTVNHCmdpdCBjYXQtZmlsZSAtcCBIRUFEIHwgc2VkIC1uZSAnMSwvXiQvcCcgfCBlZ3JlcCAn
XnRyZWUgfF5wYXJlbnQgJyA+ICIkR1BHTVNHIgoKI2lmIGl0J3Mgbm90IHZhbGlkLCBqdXN0IGRy
b3AgaXQKZ2l0IGNhdC1maWxlIC1wIEhFQUQgfCBncmVwIC1xICdeLS0tLS1CRUdJTiBQR1AgTUVT
U0FHRS0tLS0tJCcgJiYKCWdpdCBncGctdmVyaWZ5ICYmCglnaXQgY2F0LWZpbGUgLXAgSEVBRCB8
IHNlZCAtbmUgIiRQR1AicCA+PiAiJEdQR01TRyIKZ2l0IGNhdC1maWxlIC1wIEhFQUQgfCBzZWQg
LWUgJzEsL14kL2QnIHwgc2VkIC1lICIkUEdQImQgPiAiJENPTU1JVF9HUEdNU0ciCmdwZyAtLXNp
Z24gLS1hcm1vciAtbyAtICIkR1BHTVNHIiA+PiAiJENPTU1JVF9HUEdNU0ciCmdpdCBjb21taXQg
LS1hbWVuZCAtRiAiJENPTU1JVF9HUEdNU0ciIC1lCg==
--0016368e1d8a89b88d0469a099de
Content-Type: application/octet-stream; name=git-gpg-verify
Content-Disposition: attachment; filename=git-gpg-verify
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ful1fyy11

IyEvYmluL3NoCgpkaWUoKSB7CgllY2hvICIkQCIKCWV4aXQgMQp9CgpQR1A9Jy9eLS0tLS1CRUdJ
TiBQR1AgTUVTU0FHRS0tLS0tJC8sL14tLS0tLUVORCBQR1AgTUVTU0FHRS0tLS0tJC8nCkM9IiQx
IgpHUEdNU0cxPSIkKGdpdCByZXYtcGFyc2UgLS1naXQtZGlyKSIvR1BHTVNHMQpHUEdNU0cyPSIk
KGdpdCByZXYtcGFyc2UgLS1naXQtZGlyKSIvR1BHTVNHMgpbIC1uICIkMSIgXSB8fCBDPUhFQUQK
Z2l0IGNhdC1maWxlIGNvbW1pdCAkQyA+ICIkR1BHTVNHMSIKd2hpbGUgZ3JlcCAtcSAnXi0tLS0t
QkVHSU4gUEdQIE1FU1NBR0UtLS0tLSQnICIkR1BHTVNHMSI7ZG8KCVsgLWYgIiRHUEdNU0cyIiBd
ICYmIHJtIC1mICIkR1BHTVNHMiIKCWdwZyAtbyAiJEdQR01TRzIiICIkR1BHTVNHMSIgfHwgZGll
ICJGYWlsZWQgdG8gdmVyaWZ5IgoJbXYgIiRHUEdNU0cyIiAiJEdQR01TRzEiCmRvbmUKZ2l0IGNh
dC1maWxlIGNvbW1pdCAkQyB8IHNlZCAtbmUgJzEsL14kL3AnIHwgZWdyZXAgJ150cmVlIHxecGFy
ZW50ICd8Y21wIC1zICIkR1BHTVNHMSIgfHwgZGllICJGYWlsZWQgdG8gdmVyaWZ5Igo=
--0016368e1d8a89b88d0469a099de--
