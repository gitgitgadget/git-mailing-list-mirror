From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 63/83] builtin/apply: make apply_all_patches() return -1
 on error
Date: Mon, 2 May 2016 09:09:21 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605020907170.9313@virtualbox>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org> <1461504863-15946-64-git-send-email-chriscool@tuxfamily.org> <CAPig+cSVCDNRup95ay=htiXiw0UCGs6boDuqovGnQJY8imbFhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 02 09:09:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax7zB-0003j9-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 09:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbcEBHJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 03:09:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:53396 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbcEBHJh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 03:09:37 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LlpJU-1bWBkY2Y4G-00ZLwe; Mon, 02 May 2016 09:09:22
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cSVCDNRup95ay=htiXiw0UCGs6boDuqovGnQJY8imbFhQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:1GgO5gyqSidzaDUK8NzxUt9K6KLsnjX2GxDnGe6bBeAQfMIQvy9
 ngI1Lit2Ev35MEYPZTB+K3HMKECgnnea6aYu5Z+6WTIPtDunrQz+YIPPd4vds+W/VuIBfs3
 hgnMrl9DBQbUFI+5iwXBCpnl5+2oRZh+lE5TJF0LmuqcLMPWWhNx26hhx+8uzP0b3vT+E26
 oJ+qxspbb+TfC5iT8+vWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2zsAbNworLM=:1K4oQ+VDlgxZeZeijGnn9F
 IbUZICdcvJtIFHF+LB8ePv3wAszyGEx5Ep/Pa6x5lXrGnV+awGWfsDiufmEtBNvuByQYeKJdc
 NiBCKb9Kn/D1/ZkLz8xrCT8gkTinHUnhJQi8A1+esmLEpR8uiKKIdxJmPBGHt7FSQMjuHEwvW
 K/1TCeoibWJW0hYq90/+pPc67Vj8Glf31jrC8ohE8gQUARVXtIVFS4Sp0wboyc2/hyWrc6DvD
 MLdmsZjEMn7ngYBfDRuFpamWwo/kSZx6NYj54JPEIzYUKat1EH9duApGBkq7wHS5ADJCv6SkL
 fJnoDH/0kxRy412LaChwBXJSpJ10Z+2/oeSrKiGk3uWXPJpRd0KdDSTzhZ7oYkT6HAuYkH5ro
 ZM3kd5LVnhsrgFzRv/fianTzbdWUzYQSnTlo7fNSE/J21GuXX3zpnd5Pizdry4VfeNeRyK0aG
 AQlUZtULo/XjhC1RjFEYvM7M7X59xNZAW9IalbMdP7WGypgOLB6aLFReAj6//DNB3jMswwXUU
 +rZNj96V900EiJoweTuUTouYiLsLCM1umaCj+yay9FOGRueLDhSnY+HGvjXzUVTyWTiG2O5YM
 14svDREG0Tkscv29QHEzJKWiPTpF2ZcAbH7BfpZebzx063BefBOCTCNHK/FNLuYJSn2VKyM7+
 z0g3n+7RPUO39R+/S/iPc0KsGE+jPWvGXmoPZiUH2DABzMyNoPSddmWQBeEjtFBGb3bEF/WUY
 Gt4F2txSHzUKagNfH0vINcLT/pSzfig0ZBjEmqrEsG+i+cuuPWrVvDX7B6O47PvxIWHFffBh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293223>

Hi Eric,

On Sun, 1 May 2016, Eric Sunshine wrote:

> On Sun, Apr 24, 2016 at 9:34 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> > diff --git a/builtin/apply.c b/builtin/apply.c
> > @@ -4562,12 +4562,12 @@ static int apply_all_patches(struct apply_state *state,
> >
> >                 fd = open(arg, O_RDONLY);
> >                 if (fd < 0)
> > -                       die_errno(_("can't open patch '%s'"), arg);
> > +                       return error(_("can't open patch '%s': %s"), arg, strerror(errno));
> >                 read_stdin = 0;
> >                 set_default_whitespace_mode(state);
> >                 res = apply_patch(state, fd, arg, options);
> >                 if (res < 0)
> > -                       exit(1);
> > +                       return -1;
> 
> This leaks 'fd', doesn't it?

Indeed it does. I thought that I had sent a mail about fd leakage, just
resent it. Such a leakage prevented the test suite from passing after
applying this patch series on Windows and patching up several obvious
compile problems.

Ciao,
Dscho
