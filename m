From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 05/26] refs.c: move update_ref to refs.c
Date: Wed, 21 Oct 2015 15:03:30 -0400
Organization: Twitter
Message-ID: <1445454210.8302.13.camel@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
	 <1444938410-2345-6-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 21:03:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zoyfk-0004Gm-2t
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 21:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbbJUTDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 15:03:35 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35119 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbJUTDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 15:03:34 -0400
Received: by pasz6 with SMTP id z6so62381803pas.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 12:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=o1bnXfm+NxJ8yIC6ruz11fyJGTVsBQF9ntxi2fkqi9k=;
        b=RSwFyh9IWgJkPlYmgGyD0LyRn64oHgReffkNCmUEptDA+UJOoF3B/odluEYktSr1XY
         zzc9yJgHSYKZBY0vkTVNdFD/sj2vn85/R2/gNX8pdJ/lYKw9QSXAVAvy4ooAnuybCJHM
         1KlInkkCrs53bQ3KdlGnp9NLfKiTgLotkyxqWLF8asfJIw9aJ4wyrOYMpd2BSPSYVXs1
         N11Ed2TpovD9JGVsR9iFu69heY9HD4zSXBvFCmB9mFNVEbN5FnfMF+hF6tFn8Wt0SnSC
         2UC+uuQfMFTBbrVcAnZsPgnvl5sbHji5Lcj8bX/g2krfc0nqwi4Fgpeu7oRy4c7d52TW
         +Y+w==
X-Gm-Message-State: ALoCoQnibUyv6jhwDvlw+rlUDFg2ODcBIIZJA85PdbTz1VckLJtFqOq3/TkH3Kp7YHbMIfX1VR6E
X-Received: by 10.68.216.193 with SMTP id os1mr12194312pbc.110.1445454213514;
        Wed, 21 Oct 2015 12:03:33 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id hq1sm10445831pbb.43.2015.10.21.12.03.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2015 12:03:32 -0700 (PDT)
In-Reply-To: <1444938410-2345-6-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279999>

On Thu, 2015-10-15 at 15:46 -0400, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Move update_ref() to the refs.c file since this function does not
> contain any backend specific code.  Move the ref classifier functions

and write_pseudoref (will fix on reroll).
