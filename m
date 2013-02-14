From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] branch: show rebase/bisect info when possible instead
 of "(no branch)"
Date: Thu, 14 Feb 2013 16:46:21 +0700
Message-ID: <CACsJy8Ah5PvtD_AXL+tiZp-eQvzfcmvciUEK=yyOPKv-Es9YCA@mail.gmail.com>
References: <1359870520-22644-1-git-send-email-pclouds@gmail.com>
 <1360318171-17614-1-git-send-email-pclouds@gmail.com> <7v1ucq3b7e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 10:47:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5vPS-0007Hf-NC
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 10:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595Ab3BNJqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 04:46:54 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:49740 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311Ab3BNJqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 04:46:52 -0500
Received: by mail-oa0-f44.google.com with SMTP id h1so2318138oag.17
        for <git@vger.kernel.org>; Thu, 14 Feb 2013 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=kMJDOCQeFwDQC8BsMxEXFFFZd8mbFHOpbn2IGqiZQEM=;
        b=KNCnB8cIYvdLAnNXCP3XM+Ua9TtbVNMQRKZAFCw4oDMT8mcmQPhyz/+ms1ZvaltTEY
         xfRVZYcA2TJDbQKJZXz4rocZ+98gS/osjHJbn3Sb5z4GOVC0k9KcGHOcDm9/w1XLUeVW
         YL5xN7HiSYPZIBjto26PfFxe+xHPdyQ3mRCXd55RyKT2PLOJNZTP3CBvKM0mALT6ngC8
         Z2qAGyzU97XdF7GYnhUnrG3/x+r6k9/SNJ+HxqSypuqDtHk/R7qKGtkwfsYzqlQAEbsN
         +JfqsGIH6/aZvOIDgNqjRd+Cvr8SGR/wnPZJFeIa177/klCBI98MEL01naVM9JFOhVga
         kNng==
X-Received: by 10.182.72.5 with SMTP id z5mr19119914obu.24.1360835211680; Thu,
 14 Feb 2013 01:46:51 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Thu, 14 Feb 2013 01:46:21 -0800 (PST)
In-Reply-To: <7v1ucq3b7e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216303>

On Sat, Feb 9, 2013 at 1:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> We may want to refactor wt_status_print_state() and its callee a bit
> so that it and this part can share the logic without duplication and
> risk implementing subtly different decision.  wt_status used to have
> clean separation between collection phase and presentation phase,
> but the wall between the phases seems deteriorated over time as more
> "in progress" crufts have been piled on top.
>
> Such a refactoring may look larger than necessary, but on the other
> hand, I do not see this feature very useful if it can over time
> drift away from what we will see in "git status", so...

OK. I'll wait until nd/status-show-in-progress is merged to master,
then rework this patch on top.
-- 
Duy
