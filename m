From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] pack-objects: do not get distracted by broken
 symrefs
Date: Thu, 08 Oct 2015 22:10:37 +0200
Organization: gmx
Message-ID: <e1ad395fac8ab0da54338f6eba4ad838@dscho.org>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
 <cover.1444139796.git.johannes.schindelin@gmx.de>
 <f04229b0881eb7518a306ae07fe11ffc9589b1f1.1444139796.git.johannes.schindelin@gmx.de>
 <xmqq8u7evahd.fsf@gitster.mtv.corp.google.com>
 <5ee759ac37b2561eef9ab60d446ac463@dscho.org>
 <xmqqr3l5qh8f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 22:11:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkHWg-0000JE-HO
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 22:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbbJHUKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 16:10:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:50962 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616AbbJHUKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 16:10:50 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MIQlv-1Zl5wN1bpf-0049XQ; Thu, 08 Oct 2015 22:10:40
 +0200
In-Reply-To: <xmqqr3l5qh8f.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:go6EN5+WXyASjSbkNkBFaKMZgFMkbsz2z0qPaZxK4Zf8661wk/J
 GcSHGK5t5DvNY3Cw6xcFYa/Mxa6Xts5p9zVgkX36gs2cY1LhiqijMWI/PP/lKPcTBOoOeHs
 TxIAGt02QDvHya2uzwWXgPbdn+Oi10eir0lxd7iyZXlaT1QBiRhYVITpvoAvxy1CpYny72N
 rq0zk+haR/k5PJJTfZ9jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:80nkUsMQS44=:qJcA4PADs+eHxbiIBMGh8z
 s62vRMCm/QLpIueTY003USXyTr7lmJ3jEINTZZSRced3eKT1J1Ue0ImEnAVF6Y/jRyJBAR6lo
 iwZQJagefAr/o1gS8+/plr7ZyJQn4Cp489I5Y6XK9vIuAt2f48vF7TviF1qXy/mrkHTQoxH5+
 M+5lhr9b2o1YoCuukOci6K7oHFfGGDvLevsufO9rxmLzU6LOMHQVFwE4Wodj+LM8314VuiEYy
 IjTD/HImV1JsGV5432nJacsmIP8udUCF4RL/0IBEG4BXq1AYFETOSjVaN0me3uyKpVBlTaqpu
 S6r4CJ+eAFVJ+nkNIKshBBqB2lE1gAo2UheWN7U/B3PG43vbPJJ+1iDGwEyoof/+/vi6EmEMk
 /r4ID//VQIOFCL5+tZc44S1vyKWQSNDr1LMehWMbzwLaQ0OzBnzEi5MiGgvfV+xbdgyw35IqQ
 AFEvgUBCah1sbya58uOFSUQZ83+fwnkO6s1Ek1cqzcSgDcjfjnqpNGR/DrODng1G+r3k/ryNB
 eBYz+VMdPUPrLEZZr9wWS/lrrKwIJfXeoxUiwLFrqrrRLrm8NzZOWVUfQtn/wrrBA5YfBQOEo
 sfO8LdnOAVRjmGRPKSTUvYiEQXRQHsjsWL/YSfIypam2RYzJeE+Ct4c6ElRG4mIU6QwY1iRog
 jYlu1315mlb9867lE3nYntCTRtnw2D6CDAvcX+nFw1S3tyNx2yDw4TRPTu66KS9VwsfFDGjL7
 8zquXAr4aoFSaS4fM3jl2Cbq3asZgYPyo4LMpjbEL60ST58ib63R3eBqbVao5tYDlsPrSVgZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279273>

Hi Junio,

On 2015-10-08 21:42, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> Would yo kindly add the line
>>
>>     This fixes https://github.com/git-for-windows/git/issues/423
>>
>> before the Signed-off-by lines?
> 
> Oh, sorry, I missed that one.  Fixed.
> 
> Thanks.

Thank you!
Dscho
