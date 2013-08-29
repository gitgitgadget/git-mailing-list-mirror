From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 6/7] refs: add update_refs for multiple simultaneous
 updates
Date: Thu, 29 Aug 2013 15:30:28 -0400
Message-ID: <521FA154.8050105@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <518ba77096664a679e4c7212e4cc4d496c6b38d3.1377784597.git.brad.king@kitware.com> <xmqqhae85rbl.fsf@gitster.dls.corp.google.com> <521F90EC.6040208@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 21:32:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7x0-00055m-ED
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab3H2TcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 15:32:09 -0400
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41658 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753676Ab3H2TcI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 15:32:08 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]) (using TLSv1) by na3sys009aob104.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUh+ht6gp0tkYfTc8B5SGA1wCVf0bV5DQ@postini.com; Thu, 29 Aug 2013 12:32:08 PDT
Received: by mail-oa0-f48.google.com with SMTP id o17so1175440oag.7
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 12:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ICWMJY7ucUPVxDLLKFPtlfhPCl1vjcONCPLPHsxYl4M=;
        b=Y7IgpChdpnmNIj+5y1V194nokKb34dL9DPMf4koiajuMdiuZBivOAKeVRNCLC8Rc9B
         alY51RRqb8uMUV9INgJUABuzEiL8N8i4MkawIiFuGoyanaSn1SnVVky7J3wpudOlghDK
         T155CuK7RSjFeFb4gaW2D528jPWIIiSbqraoDCB8zDwN/ifAii6ih3eP/nXTxUh6CZbd
         1pEG+lsJWNTS7milfvD2+H0DHjks8emJXOdufE3myN/JIJrWlbR0LI96I6NaGtGb8nei
         7pWsKOmB6oW8ThtMFQwnHSdM/ebMUrU7M52JsnN2aNHxTMbxa+qyUp9bR4vsSAdGpWrA
         rw6g==
X-Gm-Message-State: ALoCoQnf2PJjphqE1Iu4zyZP2je0flfhHWXwm3TpEsEnG8eDUdLAs2BTqEJSCD5TQJqEwXEz47iqhEI69YPYcZUfHU3MErwhbiqvXGML96naTEANF2yPbas/2pt3EXyClB+NQCQ74jM3mtbxyZa577qEBzM3HceINQ==
X-Received: by 10.182.230.135 with SMTP id sy7mr3748567obc.24.1377804727320;
        Thu, 29 Aug 2013 12:32:07 -0700 (PDT)
X-Received: by 10.182.230.135 with SMTP id sy7mr3748562obc.24.1377804727248;
        Thu, 29 Aug 2013 12:32:07 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id hl3sm33011603obb.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 12:32:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <521F90EC.6040208@kitware.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233349>

On 08/29/2013 02:20 PM, Brad King wrote:
> I wasn't happy with the asymmetry either but forgot to raise it in
> the cover letter.  We need a way to represent "old value not given"
> as different from "old value is_null_sha1".
[snip]
> Another approach is to add a dedicated member to struct ref_update.

FYI, I chose the latter approach for simplicity.  The member
can be folded into the flags by future refactoring if needed.

-Brad
