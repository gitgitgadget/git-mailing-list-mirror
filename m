From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 03 Jun 2015 10:35:26 -0700
Message-ID: <xmqqh9qoy9sx.fsf@gitster.dls.corp.google.com>
References: <loom.20150603T104534-909@post.gmane.org>
	<20150603090654.GD32000@peff.net>
	<loom.20150603T110826-777@post.gmane.org>
	<20150603093514.GF32000@peff.net>
	<loom.20150603T114527-151@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:35:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0CZi-0008DL-EF
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241AbbFCRf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 13:35:29 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36027 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbbFCRf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 13:35:29 -0400
Received: by ieclw1 with SMTP id lw1so18641378iec.3
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LdM2cecImny5C6TkIm0ArwvJLSiuardPjCe2d+yB39E=;
        b=UwP2AxSdJjqt2k4lTEjpdHF9qKWr3ycXieSXPsXPE4g74u8mSSlxfYy36lN1RxZBy3
         TXfsmdI/xPHdzj7yihGch5Nk4E3t6scmyBrZEzU1DIFLgct5+RubmzmwvKPC1a53/SsV
         z/hKdmnbNGLp3mN7x5Yk3olvzdJWRD1ODaRa7/VCtTkL4FHPiWdxIoeX33unvUoZXMpF
         EfbDoasi63GWw4eCrELnKcEeczkxiWBoxtvwyQBdZBN8pb7ZKSme7Cup+JrkK6VAZOwN
         DbH9iv1ZV0FhOb739BHvioU6orqEdydDRAPAUzVs5hv08epxkVaVcB1+iV6mmhAnqiou
         WSsw==
X-Received: by 10.107.25.199 with SMTP id 190mr20453279ioz.11.1433352928624;
        Wed, 03 Jun 2015 10:35:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id r4sm12622570igh.9.2015.06.03.10.35.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 10:35:28 -0700 (PDT)
In-Reply-To: <loom.20150603T114527-151@post.gmane.org> (Ed Avis's message of
	"Wed, 3 Jun 2015 09:55:05 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270706>

Ed Avis <eda@waniasset.com> writes:

> If my personal experience is anything to go by, newcomers may fall into the
> habit of running 'git checkout .' to restore missing files.

Is that really true?  It all depends on why you came to a situation
to have "missing files" in the first place, I would think, but "git
checkout $path" is "I messed up the version in the working tree at
$path, and want to restore them".  One particular kind of "I messed
up" may be "I deleted by mistake" (hence making them "missing"), but
is it so common to delete things by mistake, as opposed to editing,
making a mess and realizing that the work so far was not improving
things and wanting to restart from scratch?
