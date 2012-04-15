From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Sun, 15 Apr 2012 16:37:18 -0500
Message-ID: <20120415213718.GB5813@burratino>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 23:37:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJX8S-0008Us-5E
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 23:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756Ab2DOVhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 17:37:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38260 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab2DOVhX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 17:37:23 -0400
Received: by iagz16 with SMTP id z16so6591444iag.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 14:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WUFXNy25NhpYngRd/4thAUaOmGLAFT+2rP6v9y14Hi8=;
        b=g3+Ya6VGnJkaNxgXGpFzIhSaK79mn/9G+BDnFVw6JjdyUYrF6lrtsNthYoOK4bsZhX
         bCrUrPAtzCwauf7STl4a5qayIP7qMXOiWACwHDTJRlnDMicA4YzW4NBfWD4v2rK4DTd/
         uomz8DZamQHPlvLVp/n9MYw3QdHGxgw3b/esV4vRX20BUhkhmh0INKNzw3zf8PtcKFCL
         uk0IOJky5/R+XQU6/gWbEPXP1oV3jcFdLcJctjEtnTCIZpMztOzUXxFRjgFXy+oTe6XW
         Nc0B5uz4LvZ1MCE05OP3gQVpZCNbeUA0g22HhmK9+jYYXNRUdBPK0pCHF9Pmu14NJhEf
         EB8g==
Received: by 10.50.216.136 with SMTP id oq8mr3797709igc.63.1334525842719;
        Sun, 15 Apr 2012 14:37:22 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gr1sm7830244igc.1.2012.04.15.14.37.21
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 14:37:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195592>

Felipe Contreras wrote:

> This simplifies the completions, and makes it easier to define aliases:
>
>  git_complete gf git_fetch

Sounds neat.  Unfortunately users could already be using a function
with some other purpose named git_complete in their .profile and this
would override it.  The completion script has so far stuck to a
limited namespace:

	_git_*	(completion functions)
	__git_*	(everything else, including public interfaces like __git_ps1)

A name like __git_complete should work, presumably.

Hope that helps,
Jonathan
