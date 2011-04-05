From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git exhausts memory.
Date: Tue, 5 Apr 2011 13:06:28 -0400
Message-ID: <BANLkTikanSa3D1Bd8kSySPWQhcj1y8N+qA@mail.gmail.com>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
 <alpine.LFD.2.00.1104021103130.28032@xanadu.home> <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
 <alpine.LFD.2.00.1104031110150.28032@xanadu.home> <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
 <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com> <4D9B47D2.6050909@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Alif Wahid <alif.wahid@gmail.com>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Apr 05 19:06:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q79iQ-0005Q2-PI
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 19:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab1DERGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 13:06:49 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40389 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab1DERGt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 13:06:49 -0400
Received: by vws1 with SMTP id 1so433138vws.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 10:06:48 -0700 (PDT)
Received: by 10.52.18.67 with SMTP id u3mr1803397vdd.203.1302023208396; Tue,
 05 Apr 2011 10:06:48 -0700 (PDT)
Received: by 10.52.166.133 with HTTP; Tue, 5 Apr 2011 10:06:28 -0700 (PDT)
In-Reply-To: <4D9B47D2.6050909@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170890>

On Tue, Apr 5, 2011 at 12:48, Holger Hellmuth <hellmuth@ira.uka.de> wrote:
> On 04.04.2011 16:57, Nguyen Thai Ngoc Duy wrote:
>>
>> Should we change the default to not delta if a blob exceeds predefined
>> limit (say 128M)? People who deliberately wants to delta them can
>> still set delta attr. 1.8.0 material maybe?
>
> Isn't this already done with the config variable core.bigFileThreshold ?
>
> documentation says: "Files larger than this size are stored deflated,
> without attempting delta compression. ... Default is 512 MiB on all
> platforms."

This is only implemented inside of fast-import. pack-objects does not
honor this variable.

-- 
Shawn.
