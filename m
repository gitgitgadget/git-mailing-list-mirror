From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 10/11] Fix warnings in nedmalloc when compiling with GCC 
	4.4.0
Date: Tue, 2 Jun 2009 08:38:55 +0900
Message-ID: <49b7c2350906011638j12948f1do8d1c8f28d0bf2739@mail.gmail.com>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
	 <1243786525-4493-6-git-send-email-prohaska@zib.de>
	 <1243786525-4493-7-git-send-email-prohaska@zib.de>
	 <1243786525-4493-8-git-send-email-prohaska@zib.de>
	 <1243786525-4493-9-git-send-email-prohaska@zib.de>
	 <1243786525-4493-10-git-send-email-prohaska@zib.de>
	 <1243786525-4493-11-git-send-email-prohaska@zib.de>
	 <7vhbz0mmai.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de>
	 <7vr5y3lxrj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 01:39:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBH6b-0002FY-TQ
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 01:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbZFAXiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 19:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbZFAXiz
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 19:38:55 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:57748 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbZFAXiy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 19:38:54 -0400
Received: by yw-out-2324.google.com with SMTP id 5so4481212ywb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 16:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=14oQViWbpsN5eVTaswvSG/kZZFJ56pfLLiSnhwrstk0=;
        b=wlIezhCq997jv1tm+/54GCHRRXOM22s9sDhaUeBi9KqP/08vvlXamBTaNvm8HOoaiR
         +zlzDY06dw1bhK9UiChtntgCvXHHsz1O/kOVsLN8gPghwVQPqZxde3i2n+3mrrxhXqYq
         2ZVZyLN7s7UCxgs4N2YuOpDIvJKnNlYxKyr4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BOxysCCuTS68jNzel9WzZXMcHSWVAPuR2l1pMAmxhy/do1lQ/fAC+jdVkrvs7WysHK
         BztsFXkr9uRxZ6HIwuuA7ib6IviXHwzG7gfe7YrKECCyyDMtxatzEydUOkXbBLm7qtvt
         JcLlffnEi79pQ3BvU1LRCyCUQZS/U0zzW+O0Q=
Received: by 10.151.134.6 with SMTP id l6mr12782418ybn.163.1243899535739; Mon, 
	01 Jun 2009 16:38:55 -0700 (PDT)
In-Reply-To: <7vr5y3lxrj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120490>

On Tue, Jun 2, 2009 at 1:33 AM, Junio C Hamano <gitster@pobox.com> wrote:

>>> Can somebody enlighten me what this hunk is about, and how it helps GCC
>>> 4.4?
>>
Um... It's strange.
I can not connect to  http://gcc.gnu.org website
to get GCC 4.4 manual(pdf format) currently.
ping is normal just.

[invain@fedora9 invain]$ ping gcc.gnu.org
PING gcc.gnu.org (209.132.176.174) 56(84) bytes of data.
64 bytes from sourceware.org (209.132.176.174): icmp_seq=1 ttl=40 time=194 ms
64 bytes from sourceware.org (209.132.176.174): icmp_seq=2 ttl=40 time=199 ms
^X64 bytes from sourceware.org (209.132.176.174): icmp_seq=3 ttl=40 time=193 ms
64 bytes from sourceware.org (209.132.176.174): icmp_seq=4 ttl=40 time=203 ms
^C
--- gcc.gnu.org ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3326ms
rtt min/avg/max/mdev = 193.762/198.126/203.978/4.135 ms
[invain@fedora9 invain]$
[invain@fedora9 invain]$ nmap  gcc.gnu.org
[invain@fedora9 invain]$ nmap -p 80  gcc.gnu.org

Starting Nmap 4.53 ( http://insecure.org ) at 2009-06-02 08:37 KST
Note: Host seems down. If it is really up, but blocking our ping probes, try -PN
Nmap done: 1 IP address (0 hosts up) scanned in 2.023 seconds
[invain@fedora9 invain]$



-- 
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
