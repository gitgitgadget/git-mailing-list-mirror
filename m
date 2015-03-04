From: Chris Pimlott <chris@pimlott.net>
Subject: Re: git-describe considers WC dirty incorrectly when using --git-dir
Date: Wed, 4 Mar 2015 12:12:43 -0800
Message-ID: <CACWYfsBVTcJxykWde5nNirHTdV9-yoanGAb2zVevXeewTTJJzQ@mail.gmail.com>
References: <CACWYfsCO3O-x8zBsFXoSTFZ8GiaO6CpAszUHRtjM0dCp0Q8ogg@mail.gmail.com>
	<xmqqoao88rol.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 21:12:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTFez-0004GN-OM
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 21:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbbCDUMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 15:12:45 -0500
Received: from mail-vc0-f178.google.com ([209.85.220.178]:58774 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbbCDUMo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 15:12:44 -0500
Received: by mail-vc0-f178.google.com with SMTP id id10so1342341vcb.9
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 12:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+3ewCOIMzsiiM3CdY00NV3eskDRWSHXDBnCVQkUbnWs=;
        b=up4Yiwy+ypHoI1KuhCOfY34jCVNw/CkjawtLJkJHMb8oLyds/+GRy5WATxpOng3+TA
         jNG3zVTaooYImnlBH1Ne+87v8aRWuwKla+Oo6RTQ3rsDurC4+L7xRz9HxBGSYVCIpd/h
         iv6oubE3vagRRPZ9EomwCd5otYe8Ivg3S+6UB1csstX94eAQd/afRlcBMrAmH3ehceXC
         9UlsOATGz80uOCrGO1mFUQ73prOM63JTmBStE+V8ESvAFQI6kcjqZOa404+0eujPyaAz
         ylkBInd5B4OzTJGEWaFyOg1mAOeeqGS3/3aG7JRW9aEjAl/MAEYWY7sp5Zus9IWp9K93
         5eQg==
X-Received: by 10.52.243.41 with SMTP id wv9mr9096706vdc.20.1425499963742;
 Wed, 04 Mar 2015 12:12:43 -0800 (PST)
Received: by 10.52.106.8 with HTTP; Wed, 4 Mar 2015 12:12:43 -0800 (PST)
In-Reply-To: <xmqqoao88rol.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: owfMPtNgPPlaFp0BiqEFHwaMYvw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264772>

On Wed, Mar 4, 2015 at 11:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Pimlott <chris@pimlott.net> writes:
>
>>   folio:text chris$ git --git-dir=../.git describe --always --dirty
>>   c0edd63-dirty
>
> I have a feeling that this is not limited to describe at all.  With
> the --git-dir option, you are telling Git that your GIT_DIR is over
> there and (by not using --work-tree together with that option) you
> are telling Git that you do not want Git to guess where the working
> tree is (instead, you are telling Git that you are at the top of the
> working tree), no?

Ah, my apologies, you are correct.  I was not aware of --work-tree and
didn't realize that specifying --git-dir would turn off the normal
working tree discovery process.  Thanks!
