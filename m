From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] worktree: add 'list' command
Date: Tue, 11 Aug 2015 08:46:56 -0700
Message-ID: <xmqqy4hhsu8f.fsf@gitster.dls.corp.google.com>
References: <1439239982-42826-1-git-send-email-rappazzo@gmail.com>
	<1439239982-42826-2-git-send-email-rappazzo@gmail.com>
	<1439261725.5283.9.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Rappazzo <rappazzo@gmail.com>, sunshine@sunshineco.com,
	git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:47:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPBlW-0000N9-Nd
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 17:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbbHKPq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 11:46:58 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35746 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965045AbbHKPq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 11:46:58 -0400
Received: by pdrg1 with SMTP id g1so84943261pdr.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mcq/UZoP3x8m5jOZwmIKvEsKSQRKumPvx0DVIzdk/6k=;
        b=aW7U6VI1szaAM+c5bQrvLu9ZVuLIJoU5Otde1Nm3uPPccgBj1HUVUxynVJK1aUAXLB
         baO5PxFMZdxEPw/pAiVnOywZ2TemxrXnEIiY9qgqoXX08NKgoTttDYH9HqNL6+w1X1hk
         2n0JaDfeRIaMcHtW/mE+sNoDH2sTeQ8kcrUQuiN4+6o2GwJ5j9YyG8siFAz78WMDbgeP
         0xEDUgcFFhRH1fMbQnFjL6S2vDbuzi+2Cfd8MOhCskUKs33aFOZ84yF8eYaEuEd2lKeQ
         eKLOzzK832NWWVvKMgyQMnDPtEUfhvu2Y/4RaP6Gu3hO4Sh/cz4CWxzOV1hErc/H01wa
         IdSw==
X-Received: by 10.70.43.79 with SMTP id u15mr48161031pdl.84.1439308017913;
        Tue, 11 Aug 2015 08:46:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id qc2sm3113073pbc.79.2015.08.11.08.46.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 08:46:57 -0700 (PDT)
In-Reply-To: <1439261725.5283.9.camel@twopensource.com> (David Turner's
	message of "Mon, 10 Aug 2015 22:55:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275694>

David Turner <dturner@twopensource.com> writes:

> On Mon, 2015-08-10 at 16:53 -0400, Michael Rappazzo wrote:
>> +			while ((d = readdir(dir)) != NULL) {
>
> I think it would be useful to break this loop out into a
> for_each_worktree function.

Very good point.
