From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Wed, 17 Apr 2013 08:48:07 -0700
Message-ID: <20130417154807.GA3499@elie.Belkin>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <20130416025840.GH3262@elie.Belkin>
 <CALkWK0kDgSicNejydLsH6iqj-yDYGz6CKd+kbn4EW1HxgAxsBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 17:48:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USUat-00084v-FU
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 17:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251Ab3DQPsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 11:48:19 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:62329 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab3DQPsS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 11:48:18 -0400
Received: by mail-pb0-f52.google.com with SMTP id mc8so948688pbc.39
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=IOAi9cabl2bcGUpJzBSKWcyi7mHdB1hQBS0WjrgrNmc=;
        b=cEyOf12zKl/iyLVqeuENyvyz5B5uuC+d2LMVE1DRzwsWNQrKMLNnUwskfSQyeB0NCk
         G/7xAFRXTd1/VBsfpz0QWvfK6dlcFvQfrL8EG5BTF6FWGc5cv1x442KsxAKOKNxMaKb/
         b+/4S8PDA8gCH8X8XpeMjgB5b4vt4kVQXIvbwn9syxmxN6XgIwXPaVuefXNOvt+G2Qml
         MNudXmuuL3zHqDo6Xg/CGK6vlIco1DDF7jQSEZQyVsiEWRSLbxCoYPYUaInPgOGxHse8
         Zvs9KU1y6i8ejG9vHnlJtbkU3gCOBhgjuV4GpoIeZNBomEnQ/2h48UaC6lJfbgvIyA9I
         W6xw==
X-Received: by 10.67.10.133 with SMTP id ea5mr9505949pad.135.1366213698233;
        Wed, 17 Apr 2013 08:48:18 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qh4sm7563951pac.8.2013.04.17.08.48.15
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 08:48:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kDgSicNejydLsH6iqj-yDYGz6CKd+kbn4EW1HxgAxsBA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221548>

Ramkumar Ramachandra wrote:

> 2. This ugliness complicates implementation of add/ rm/ mv, because
> each of them will have to know about this contrived path solution.

Why is that?  Can't they look at the gitfile or call some helper
(that happens to be part of the same binary)?
