From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 15:49:58 -0500
Message-ID: <53558476703cb_5c94d452ec4e@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:00:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLKH-0004Nc-V8
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbaDUVAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:00:25 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:57073 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502AbaDUVAV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:00:21 -0400
Received: by mail-yk0-f174.google.com with SMTP id 20so3820739yks.19
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=F1LSRKhXmJld7KIR5Www2dsoYzDetju5RBzrzc0E86g=;
        b=z2O50ShK9ZPKuODmi2B+l+BI4+GkQ/UXLDnkWHICLCnQM7VC1+eL68Ctes2Vq8vqsz
         YOBHxLfgIYgcnL6LG2Z0R6n3Y2NBNO/4GbZPFhvw06me3aoyULz0+7wyk11szXWLooOs
         IRZMfz3ykAdFjCvA6yMuDBAIWUW6pdjQwe+W6BW5FwBcPp1UueiofGu/WzbWkdyVeFbc
         yMoGbUMhXEo6tMq1PBekXiIY2nfdIzbPB8M+cuRfutahdiWYeKrHhPBX2TpWPszk2qBX
         zBt9HfZsqP1rROTCOG0hdYOmwtLUmfnhXKzJ0ZmdVDmvxF25jkwGgjurTNI6IxavMhdv
         yZtA==
X-Received: by 10.236.10.82 with SMTP id 58mr5672574yhu.118.1398114020733;
        Mon, 21 Apr 2014 14:00:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id p68sm73182549yho.10.2014.04.21.14.00.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 14:00:19 -0700 (PDT)
In-Reply-To: <5355793A.5020000@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246638>

Ilya Bobyr wrote:
> On 4/20/2014 7:23 PM, Felipe Contreras wrote:
> > This hook is invoked whenever a branch is updated, either when a branch
> > is created or updated with 'git branch', or when it's rebased with 'git
> > rebase'. It receives two parameters; the name of the branch, and the
> > SHA-1 of the latest commit, additionally, if there was a base commit the
> > branch was rebased onto, a third parameter contains it.
> 
> And the old branch SHA could be found from in the reflog, correct?

Actually the old branch SHA-1 is actually the current one, since the branch
hasn't been updated at that point. Personally I don't see much value in adding
something the script can easily find out.

-- 
Felipe Contreras
