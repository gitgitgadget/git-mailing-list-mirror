From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] refs: document transaction semantics
Date: Thu, 25 Feb 2016 15:50:38 -0500
Organization: Twitter
Message-ID: <1456433438.18017.53.camel@twopensource.com>
References: <CACsJy8DDVbz9LnX5HM_2HB+uDvqzS7LU=12gxhxJFqYPHp0Tvg@mail.gmail.com>
	 <1456430746-5565-1-git-send-email-dturner@twopensource.com>
	 <1456431013.18017.50.camel@twopensource.com>
	 <xmqqvb5cmsup.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:50:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2s1-0002MW-4J
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbcBYUul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:50:41 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33812 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbcBYUuk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:50:40 -0500
Received: by mail-qg0-f50.google.com with SMTP id b67so50103844qgb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 12:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=m4reQSBwfcfFYqj67NxZ3FfOcG5a90AkbiP1bK5vJ/E=;
        b=gn1XhzO1nsHfSj2Tdx4v9P1WBUXrbqzP6o5LcqVVyPdpOaWwLuZ/NB2MMZH4VAsiWk
         60Lbtlf8GPL27+WSPETrhslvYTFMHWRFcnMj9mn/BfT7hlvSS56CmtsL6iCznlFSEBpO
         mfzxjUJ9dumor0GROidXd5fXTygw98wXspuGpiCsFLwDmSPsJca++jPmkssSzDXPhnIM
         vnZDphpxvID2yv9mZPXfTTnMQ6MsfMBCnRcYsf0acWTwuE9li245DVFkrn2XcOaRgqcR
         YXNcHsmIYkPRHIvEujRVoQ80jqUNG9xSXsbjB5yQXfvcRtNEfMtdBmUoC4rLaMBbZJ8Z
         Mq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=m4reQSBwfcfFYqj67NxZ3FfOcG5a90AkbiP1bK5vJ/E=;
        b=bHCg6koeky92dsfoHR2oKYoq5lVP/EoKF36XyiTgpytHYoDnjcqNt0qAwoEeW81fii
         B0FNEePsYSb28dxE0Z7sqze0N7IZAfTKk+zywMsc1JOVmBfFyAiAmwywwlput5hNK0hW
         AKrTBY7aDtz0BtVu4fyJWd0BWjQ9fB2xThJMzCclMLFBbg4GtDDTleVb/1qB2pcfGn7a
         gKLomok/ruMymZbkRIQGLePL1DdDyV+3JH8/bfxTSG+r+vKPCfP5nuFt7eCPqX6ACxex
         o8034/G75QMM2HNwhyS3HPxAjgKuEXcqmNThQOGkEcsW0lrRmtEPueLvikLZNkmuDn0w
         jS0g==
X-Gm-Message-State: AG10YOT3vTJ9HkDznNH+P5tq9ZoDeFTP/DBhih7VjzcjNeeQCXa1vo9bGJsD6wBrMXKzNw==
X-Received: by 10.140.104.50 with SMTP id z47mr58979683qge.68.1456433439970;
        Thu, 25 Feb 2016 12:50:39 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b111sm3966078qge.47.2016.02.25.12.50.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 12:50:38 -0800 (PST)
In-Reply-To: <xmqqvb5cmsup.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287439>

On Thu, 2016-02-25 at 12:34 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > I thought it would be better in the api docs, since it's a design
> > decision that all backends should follow.
> 
> Makes sense; as this describes an already available API, it
> shouldn't have to wait for the remainder of your series and can just
> go to 'master' (or even to 'maint' if we wanted to), right?

Yes.
