From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] add throughput to progress display
Date: Tue, 30 Oct 2007 09:43:53 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710300935330.21255@xanadu.home>
References: <alpine.LFD.0.9999.0710291904190.22100@xanadu.home>
 <7vr6jdm2eb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 14:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImrOA-0001qT-CJ
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 14:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbXJ3NoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 09:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbXJ3NoB
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 09:44:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39130 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbXJ3Nn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 09:43:59 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ001OC8T6GUG0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 09:43:54 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vr6jdm2eb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 30 Oct 2007, Junio C Hamano wrote:

> Very nice.
> 
> I however wonder why this breaks t1004 when applied on top of
> lt/rename topic.

Well... sh*t happens.

Could you please simply amend [PATCH 1/2] with the patch below:

diff --git a/progress.c b/progress.c
index d2460dd..a388e54 100644
--- a/progress.c
+++ b/progress.c
@@ -143,6 +143,7 @@ void start_progress_delay(struct progress *progress, const char *title,
 	progress->last_percent = -1;
 	progress->delayed_percent_treshold = percent_treshold;
 	progress->delay = delay;
+	progress->throughput = NULL;
 	set_progress_signal();
 }
 
@@ -160,5 +161,4 @@ void stop_progress(struct progress *progress)
 	}
 	clear_progress_signal();
 	free(progress->throughput);
-	progress->throughput = NULL;
 }


Nicolas
