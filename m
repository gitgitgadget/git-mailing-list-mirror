From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC 1/2] sha1_file: close all pack files after running
Date: Sun, 04 Oct 2015 16:53:30 +0200
Organization: gmx
Message-ID: <21bd1c9c394a421bc06c6fa1837f16b6@dscho.org>
References: <1443670163-31193-1-git-send-email-max@max630.net>
 <1443670163-31193-2-git-send-email-max@max630.net>
 <33b74e875c7298f67640f5850e88c152@dscho.org>
 <763ac2b63d56d250e5e1a27f490f79db@dscho.org>
 <20151002192148.GD26154@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Oct 04 16:53:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZikfY-0008Tc-4v
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 16:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbbJDOxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 10:53:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:61453 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbbJDOxi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 10:53:38 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lk7T8-1aKpZR0lqs-00c6Xu; Sun, 04 Oct 2015 16:53:31
 +0200
In-Reply-To: <20151002192148.GD26154@wheezy.local>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:hQe4alNf6SkjNzDuL01MeDhmkG/RGPfRQTcu9xsOWiHaLjonGvz
 B4W1sIdB5NaiLLG/l77okCrLjpx9WxzkYgGKAokU1Gm8IdAgttaGH2DHOgLzpDUfMwnIwm5
 Mv7dvAfWglBB9prVx4I/iV14JOIoxzziHS+G5HCsXYjzukxMHpR75hmCNR0K8JKlT5qCTi7
 JncGImfZrqB91tpHl++vQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ihy8jWRmlsk=:dyuE04rKWfgOz0XtwDRRDC
 UHVK1Mx6hf3azvWJlCfCVp+ZNSjAbbZRuqCE2FMaEIjUwoz1dhVs1pyvbu+5mS65XJc5oU/hb
 IuEyc4lY5tTmeQcJWM7mY4FI5+Fln9oaP86KA9oWLXQdCFxO4Pn4xbktpszbjqFCxRhJ4I//i
 O97w2viAFkWv1XCCwMGaAGfiC24HIPSthaV8G/bLP8QUY9iDV+8NKVE2FvSkqiGKLtE5PBF7x
 5p5HhZFopK7IZf7ISR9S7Qp3oyqgGluoqGFrU2L95V3aaNKJMTJVcePBYhqOhgYTKZqSqOxdJ
 ZXytF4lsxmUMntJHrd6sdGeXNXwjIFnGW72upkdldaGGK+ooeXlOohphNk5Z/IEyU+DQo/giu
 ObyUZPw/bPLT0WZq6iSSNwLYC1kXuCapjtvPIbRIJeXRaeKH5MIXoh5f5hf7se3Rp7E2ITE8J
 zwKuRq7iyZ3HRIdN2kYKaXZqTAmkLKs4waY2vdzH2DFkVuxi6ZD4jbAsxts/JUJaVhhnkcZNV
 Q3oWYHgVphJE8ILfmlmsz8ju8BLqqIY3heqmeyHR5MPFtpF0f+e/Loa+IfdKgNLMrAx2hGX28
 1zOqRGK52UGIcpSvf7qqQAMAMsaEsFdo4WsQr5hBu4CbfGibpsO7SDnGlXlQuJ5mobqrGYRge
 Uv7Y+3f6ArycMXIaI+Pz9i71uOPkOFbz46JDEi7czjHCBWfWJRKa2JWaUl9J1AnR9/BVYLrnB
 iXbZuZmB1TlD18L8bhYr3xBR+vbyR4Q5IWtlA/VRrug0MED0dMO+rWub67C54LwX6L34u9Bc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279001>

Hi Max,

On 2015-10-02 21:21, Max Kirillov wrote:
> On Fri, Oct 02, 2015 at 12:13:40PM +0200, Johannes Schindelin wrote:
>> On 2015-10-02 12:05, Johannes Schindelin wrote:
>>
>> > On 2015-10-01 05:29, Max Kirillov wrote:
>>>> When a builtin has done its job, but waits for pager or not waited
>>>> by its caller and still hanging it keeps pack files opened.
>>>> This can cause a number of issues, for example on Windows git gc
>>>> cannot remove the packs.
>>
>> Could you do me another favor? It seems that you want to
>> work on this, so I will step back (I have to take off for
>> the weekend very soon anyway, so I am really glad that you
>> take care of it). But I would really love to see the line
> 
> As I explained in other message, your case is a bit
> different.

I guess then we would need two different patches for the two different fixes, at least.

So now I am unsure how to proceed: I do not want to step on your toes, but I also want to see my use case fixed and I want to move forward on this. At the moment, it looks as if we are at an impasse.

Ciao,
Johannes
