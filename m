From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/19] index-helper: add Windows support
Date: Thu, 17 Mar 2016 13:18:36 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603171309301.4690@virtualbox>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com> <1457548582-28302-10-git-send-email-dturner@twopensource.com> <CACsJy8DSORe6chXkufJB8ZYxi0kG6dUUbW_Spb=60bcxETasLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 13:18:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agWt4-0001wu-Rp
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 13:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbcCQMSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 08:18:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:58000 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030285AbcCQMSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 08:18:41 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MgXCF-1aUFUQ2u2B-00NzvX; Thu, 17 Mar 2016 13:18:37
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8DSORe6chXkufJB8ZYxi0kG6dUUbW_Spb=60bcxETasLQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:nqzm8aVJCwDJxbh1Sq73Yp+ZYmjv5X/a7tk/MbhRsCM0CgJD0NM
 k57ZSrvAcbY7t6yQwX4BVw+JKpYuCLsHabZAuTk4ChKsKRK1hBykKseHkrj3xKGOp8frqIj
 07Z179+jfHArivZUZ2aBqbi8sNsH4QjxIYhqyBsZKiW24QUHm9Mc2SK9Ixn+PKr//1b3mW6
 VLwt2z8+DIwoEWrP+AiYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QUedxlvSwXg=:1nxKjK9Ua86TzAgERAQXIH
 kqzfJJ9EF+PVWvgapYOEOT+MxT9/HnIeiy7IqDmDBWpcSvzet5RjBYNjVPz5l7g71i6mU+azC
 8kowmEDobdg4QTFzNHJ2N/UVKqUjsoMk489dF27060O2f6E4UMZxui94dLH705klixIXbCiAe
 MuMMSN6pVtnLX/ggfwAHngy7fN8BMn1GF3I5cWAggZzEDSBqQiAWsUUWDxIPC5FBv7d53ZkjS
 8PKeanX0/IsSNn0un84qNUkoNGdma7dM2O9RQyiFj+g0fXT0dHdrzadQOJj0EAZKv19WAY1hi
 eiKD43r9jwSBuxuDfohJXT5XuPhYaqyJjPOyeeTPZyp0a3fHPdpcWqgZl66yq3yWWvX8aMeu7
 6nKavUEUtKyibdZI5oWcJjFPo+xeBP21iKX/iI/e0eyxFXfUjPPSEBd/oSkD7e+mXmNnp8sVU
 ENXQCvZX29ansRwowNA368ub4Gx0rOQZ0to7UN4uk/mrjXPgfk6jkwLAr42alpNgGPrLpsMhT
 oTxvoClACUPDpU0k8vpVJPLX9phLBMrJa2ouSSbaDgFZ6vuqzDyYMQxR24uaDW8ELOkVQOqhS
 hf6Dlmrx578zA2UrmPhw3kdjPzh6zvUExkv+VDyWCj2J1tubz+fiSo3fjpNXGL0HWqFqmFkDG
 S5AydKZrpW7ry4UTlDKaG6RidRLwwqeFqvzGvpxJqCRBLM3SqHH6aILqKwdWnrXML13Vnp2ip
 BqTkk2ByZavToYZXrsc6E8pIsp4J3VlIu1BvIhFejZAuLVo1ZCqvc70VePlp9JgQ0MaD+Ch3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289099>

Hi Duy,

On Wed, 16 Mar 2016, Duy Nguyen wrote:

> I think it's safe to drop this patch now. It's mostly to prove that it
> could work on Windows. But I don't think it's tested a lot (even I
> only occasionally test it under wine).

I agree that it is more important to get the basics right (such as:
concurrent access, elegant interface to watchman, pluggable backends
different than watchman, support for *other* Git clients modifying the
index under index-helper's feet, etc).

We will try to keep the Windows end going at the same time.

Please note that there is one very important difference between Windows vs
Linux when it comes to shared memory: on Windows, the memory is released
as soon as the last user goes away.

Ciao,
Dscho
