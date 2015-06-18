From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t3404: demonstrate CHERRY_PICK_HEAD bug
Date: Thu, 18 Jun 2015 09:00:29 -0700
Message-ID: <xmqqoakdf1lu.fsf@gitster.dls.corp.google.com>
References: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
	<cover.1434528725.git.johannes.schindelin@gmx.de>
	<f76ca5d0b6687a4d2ee4f587d8ba75a643a33c04.1434528725.git.johannes.schindelin@gmx.de>
	<xmqqtwu66xzg.fsf@gitster.dls.corp.google.com>
	<c2b427850cc6f298bee017123639c4df@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 18:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5cF7-0000iA-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 18:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbbFRQAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 12:00:35 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35936 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbbFRQAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 12:00:31 -0400
Received: by iecrd14 with SMTP id rd14so57759925iec.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Z3l+b2gAq84jCOoUIJwBiCIoBXvFYMU6DPWZo1cL3OE=;
        b=Crr7s7e1of/XI9YWah7v8V9vOhW7TYvIgmVHHw8C4CAM4VZiePPdNTOkjpJqxeTqU+
         Gsy6Dmk2nv9qpskmFcMUk6gk420/iPglTO+K5ICpsBSl6qUY/eHmzhHSuVjoYx2Bbq2s
         XF9GfdPe5nX6b86E2398oav97h9T0Yr5AgSD5C6/4c5zBOP99YvbW0wsIqTPqXrdD6tf
         GfpVqJ7a1CoWHTYxOdSfuSR2LK0CJxOPs4B8mFc+SydDhKLMs1vtcU1GLXqfzZ3judvu
         rHL/EWzrRfOCD/c/LhN1/cs2lCB27xQdfanQXx99l72nXevxgYbyDhgnpMqy4gRgDJnp
         rsgA==
X-Received: by 10.107.39.209 with SMTP id n200mr15850285ion.59.1434643230987;
        Thu, 18 Jun 2015 09:00:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id pg5sm5773326igb.4.2015.06.18.09.00.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 09:00:30 -0700 (PDT)
In-Reply-To: <c2b427850cc6f298bee017123639c4df@www.dscho.org> (Johannes
	Schindelin's message of "Thu, 18 Jun 2015 13:22:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272020>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>>> +	git diff seq-onto &&
>> 
>> I am puzzled with this "diff"; what is this about?  Is it a remnant
>> from an earlier debugging session, or is it making sure seq-onto is
>> a valid tree-ish?
>
> The idea is to verify that we end up with the same tree even if we
> exchanged the latest two patches. I can remove it if you want as it is
> not strictly necessary, but I would like to keep it just to make sure
> that we did not end up with an incomplete rebase.

I agree that such a verification is a very good thing to have here.
But you would need to ask "git diff" to signal that it found no
differences with --exit-code or --quiet, I would think.

Thanks.
