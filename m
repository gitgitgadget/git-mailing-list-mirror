From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 13:28:34 -0600
Message-ID: <20120130192834.GA28920@burratino>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
 <1327944197-6379-5-git-send-email-felipec@infradead.org>
 <20120130175324.GH10618@burratino>
 <CAMP44s0ACC+AnwHGtBLe8C1S_sxWj6SbMbawDThvLQAA0pKMYQ@mail.gmail.com>
 <20120130182547.GA22549@burratino>
 <7vliopatxg.fsf@alter.siamese.dyndns.org>
 <CAMP44s0dU5zQLnen_DSONOum7P1UsPTASSkF1sJE2m7kAwx21A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipec@infradead.org>, git@vger.kernel.org,
	Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 20:28:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrwuP-0002A0-1a
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 20:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207Ab2A3T2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 14:28:52 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58679 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab2A3T2v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 14:28:51 -0500
Received: by iacb35 with SMTP id b35so5568107iac.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 11:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0dtb5w7TsHDgGORIs08W9VQq7ghc0gKQdzIqGvHRqkY=;
        b=YCe2T1AvselxFEVlPEtyG+YS18uGIqJiRjQXPYsbY93jHPwm6jfqXNH/YLtN97CztE
         q5pFLSIp1Ju5Iq1hUeO+YoRD+GnwB51o8cGOZ0oBNWmpmrEwhp5O6mtG2tZDuPCEX9lu
         JyFIN0d195UraWAG8r+gPvLlXbQUkoX/yo3jg=
Received: by 10.50.189.137 with SMTP id gi9mr5089559igc.29.1327951730672;
        Mon, 30 Jan 2012 11:28:50 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g34sm19324676ibk.10.2012.01.30.11.28.49
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 11:28:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0dU5zQLnen_DSONOum7P1UsPTASSkF1sJE2m7kAwx21A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189405>

Felipe Contreras wrote:

> What would you rather use?
>
> [ "$__git_merge_strategies" ] &&
> __git_merge_strategies=$(__git_list_merge_strategies)
>
> That's 90 characters long. Although much better without the 2>/dev/null.
>
> if [ "$__git_merge_strategies" ]; then
>   __git_merge_strategies=$(__git_list_merge_strategies)
> fi

Neither, since they both have the test inverted.  But I prefer to
explicitly use the "-n" operator.

	[[ -n $__git_merge_strategies ]] ||
	__git_merge_strategies=$(__git_list_merge_strategies)

seems as fine as any other spelling to me.  It means "either this
value has already been computed and cached, or we need to compute it".
