From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [RFC 3/3] reset: Change the default behavior to use "--merge"
 during a merge
Date: Tue, 11 Mar 2014 00:39:43 -0400
Message-ID: <531E938F.4060602@gmail.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com> <1393437985-31401-4-git-send-email-andrew.kw.w@gmail.com> <vpq8usxenul.fsf@anie.imag.fr> <xmqqfvn538a6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 05:40:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNEUg-00017d-HC
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 05:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbaCKEkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 00:40:41 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:44525 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbaCKEkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 00:40:41 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so10299082igc.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 21:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ffkBEAGl/H8ra/f+VV7YDFjX2rw1SsuEHzZV9OKgP7M=;
        b=wBh2Ia41Fw1POkX4vXYLk8a3QlvoU34lPXNn9SqOnP5sFj74UeuXMsK/ezOegMqOmn
         aEdoeHYaED3QmpdrswfxyZTHf0fCAb8eZZjAX3RzIVwCy3zffTRplr/9WYX4YcOyjG4p
         Zr9fMEK0e40hn99JXWUrGfGqGrN8GpHhMrKM7vghqXzj8rfuf1dTQKgyyqVuvcDOxuQl
         WEovjJAdhIhnDrMNx6ez8uD9sC2q4/heFdLypdjMt4JKV0EaogiHcK/xJ+k7BHNB7BEd
         rsK2r8Yj7oJTXhobQMH5wUrH773mVY+0MbnWeW4LuaOakxxzyHkbx9Du63LksSqzAomX
         hDOQ==
X-Received: by 10.50.119.132 with SMTP id ku4mr21232879igb.35.1394512840725;
        Mon, 10 Mar 2014 21:40:40 -0700 (PDT)
Received: from [192.168.1.4] (24-212-191-132.cable.teksavvy.com. [24.212.191.132])
        by mx.google.com with ESMTPSA id v2sm43558351igk.7.2014.03.10.21.40.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Mar 2014 21:40:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130719 Thunderbird/17.0.7
In-Reply-To: <xmqqfvn538a6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243843>

On 02/26/14 15:53, Junio C Hamano wrote:
>  - start warning against "reset" (no mode specifier) and "reset --mixed"
>    when the index is unmerged *and* MERGE_HEAD exists; and then
Why do we also want to check if index is unmerged? This situation can
happen regardless of having conflicts or not (--no-commit, aborting the
editor, etc.). As long as the user is in the middle of a merge
(MERGE_HEAD exists), shouldn't they be warned if they used "git reset"?
