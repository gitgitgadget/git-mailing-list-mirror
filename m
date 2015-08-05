From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] am: let command-line options override saved options
Date: Wed, 05 Aug 2015 08:41:44 -0700
Message-ID: <xmqq37zx68uf.fsf@gitster.dls.corp.google.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
	<1438697331-29948-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 17:41:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN0pE-0006DF-Iy
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 17:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbbHEPls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 11:41:48 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34935 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbbHEPlr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 11:41:47 -0400
Received: by pabxd6 with SMTP id xd6so21267643pab.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=m72OBpNFW8NCSGgHc7U+fwcMBQP6u6BYUVv+Rhk3E/0=;
        b=pSnqyy2V+an9oyWDhdi3n6sivf/ZylhvNG0P5HM2qemf07tOgzeUdMkeW3nTGqVOdJ
         9ZtMnbHb6sMZO5vLkT4WcO3YeASou2CGMx9wslM0gGIUSgk6mfj9cMuEqBWXcZPap8rA
         TL9Dy5O4yDjYrPpYq4E5j4Fc+5/lTbCMC0IPHu1f4pab9/bEQj9q2f9AB4h3bNOnlfKS
         4JtHkEdoTXAcoWyWWaRMg/pZlnIXTlxxdkCpZaR+4727WYsdAVghI90BZ7QaStT01vHy
         3jJW0GfFBYqYTX6a3+UYtEwb3cbmpd0KOCLmS814A7euWoXRUrYU856wTzoC4UouakTa
         eNag==
X-Received: by 10.67.5.2 with SMTP id ci2mr20369341pad.97.1438789306729;
        Wed, 05 Aug 2015 08:41:46 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id kr1sm3285656pbc.93.2015.08.05.08.41.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 08:41:45 -0700 (PDT)
In-Reply-To: <1438697331-29948-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Tue, 4 Aug 2015 22:08:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275371>

Interesting.  This seems to break test under prove.

    cd t && make T=t4153-am-resume-override-opts.sh prove

does not seem to return.
