From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC PATCH] repack: make repack -a equivalent to repack -A and
 drop previous -a behavior
Date: Thu, 13 Nov 2008 19:36:45 -0600
Message-ID: <Dei99j9xFoGAh0A3LCO0zx3LqCb4lViSZpGvv_KGn38@cipher.nrlssc.navy.mil>
References: <7xh1_tFsJkHTjg4Hjm-R4mGSRfYyGFmLI62OMmaNg32f86EbVIYvYrGiYpEGkvooY4pUM1e7CHk@cipher.nrlssc.navy.mil> <20081114000219.GB5285@atjola.homenet> <jKWdt94ZxgNW0UAgUUW-qjTtpWohpQXMfvw-AUmOXND8SD5yFw0N8w@cipher.nrlssc.navy.mil> <20081114012502.GC5285@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 14 02:38:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ndQ-0001w0-U8
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 02:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbYKNBgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 20:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbYKNBgv
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 20:36:51 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48849 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbYKNBgv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 20:36:51 -0500
Received: by mail.nrlssc.navy.mil id mAE1akXd008112; Thu, 13 Nov 2008 19:36:46 -0600
In-Reply-To: <20081114012502.GC5285@atjola.homenet>
X-OriginalArrivalTime: 14 Nov 2008 01:36:46.0428 (UTC) FILETIME=[74B9D9C0:01C945F9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100944>

Bj=F6rn Steinbrink wrote:
> On 2008.11.13 18:53:29 -0600, Brandon Casey wrote:
>> Bj=F6rn Steinbrink wrote:
>>> I didn't check all the (proposed) commits for that branch, so just =
let
>>> me know if I'm missing anything, but doesn't this change mean that =
you
>>> just lose what "-ad" did?
>> yes.
>>
>>> We have:
>>> 	-a	Create a new pack, containing all reachable objects
>>> 	-A	Same as -a
>>> 	-ad	Same as -a, and drop all old packs and loose objects
>> by loose objects, I assume you mean packed unreachable objects.
>=20
> No, actually I just totally ignored the fact that -a of course alread=
y
> deletes the loose objects.

Actually, I had forgotten that repack deletes any loose objects at all.
It does call prune-packed, but only when -d is used.

> IMHO, "git gc" already provides enough safety. I tend to see "gc" as =
the
> regular "just use it" tool, while repack gives me more control over h=
ow
> I want things to be done, without forcing me to use the real plumbing=
 or
> to fumble around with the configuration for gc. And when I want contr=
ol,
> I'm generally prepared to shoot myself in the foot.

I think you're right. Thanks for providing an example of a real use cas=
e.

-brandon
