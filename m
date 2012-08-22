From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 20:18:14 +0200
Message-ID: <004001cd8092$7f9e6540$7edb2fc0$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de> <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com> <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de> <7v628epzia.fsf@alter.siamese.dyndns.org> <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de> <7vy5l9lj6m.fsf@alter.siamese.dyndns.org> <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de> <7v4nnxld24.fsf@alter.siamese.dyndns.org> <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de> <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com> <503519B3.1020403@kdbg.org> <003e01cd8090$55126fd0$ff374f70$@schmitz-digital.de> <50352053.609@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "'Brandon Casey'" <drafnel@gmail.com>,
	"'Junio C Hamano'" <gitster@pobox.com>,
	"'Shawn Pearce'" <spearce@spearce.org>, <git@vger.kernel.org>,
	<rsbecker@nexbridge.com>
To: "'Johannes Sixt'" <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:18:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4FW1-00015g-2c
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933197Ab2HVSSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:18:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:62326 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933100Ab2HVSSq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:18:46 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MgHFG-1TGzCl09sU-00NI2D; Wed, 22 Aug 2012 20:18:21 +0200
In-Reply-To: <50352053.609@kdbg.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7EfAdIAjkoB0Br5KAKVWWsnAm8TuDMCb+a+7QMjYLRhAalBYtECWH7b+QJMED4YAf2RaVICtbjc6wMYwuxrAc2I9d6VIAkjQA==
Content-Language: de
X-Provags-ID: V02:K0:lkRfLOdHLBgE4HGPfKV9uLjSrkb65iU4X9SyFu4DBi6
 OrV1jBlbWtBug84IIgaMXGTgwL+ubCX3/rK0VT9eerE/9O6Fq2
 6+W3BWOkahuYW54sPbTe/p+uFysMqVC7slipY7qslT6N8LEsc+
 sPWcMXzdbXXK3vjbI/iSNDUV1nB/xs0hIntWsbfFoSrq4BJYYl
 vePtFbWaEVyfpyh2okLEN4Uejiv8XzPEDHWi29gYilknhUjfhU
 6vPkbOb7OS57hsJt/262YR80jQTHJJqHTck3cSAYCABkLRN+6p
 XLWw8RZsUDTUhCXCiU/UiYAuNYqzSRrhFag4QM9wCfB7EEt0Ih
 ijVYiLy5XJaHU74kRAvike8noKy8hT3VMFD4DYtth3DxGI8lZg
 LGvT1UB1z6fcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204059>

> -----Original Message-----
> From: Johannes Sixt [mailto:j6t@kdbg.org]
> Sent: Wednesday, August 22, 2012 8:09 PM
> To: Joachim Schmitz
> Cc: 'Brandon Casey'; 'Junio C Hamano'; 'Shawn Pearce'; git@vger.kernel.org;
> rsbecker@nexbridge.com
> Subject: Re: Porting git to HP NonStop
> 
> Am 22.08.2012 20:02, schrieb Joachim Schmitz:
> >> From: Johannes Sixt [mailto:j6t@kdbg.org] Don't use x* wrappers in
> >> the compat layer, at least not those that allocate
> >> memory: They behave unpredictably due to try_to_free_routine and may
> >> lead to recursive invocations.
> >
> > I was just following orders ;-)
> > What about the other proposal, xmemdupz? Same story I guess?
> 
> xmemdupz calls xmalloc, so, yes, same story.

So back to my original patch, using strdup, check the return value, etc.

Bye, Jojo
