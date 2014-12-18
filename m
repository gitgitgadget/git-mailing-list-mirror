From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Introducing a test_create_repo_bare (was Re: [PATCHv2 6/6]
 t5543-atomic-push.sh: add basic tests for atomic pushes)
Date: Wed, 17 Dec 2014 16:28:25 -0800
Message-ID: <20141218002825.GQ29365@google.com>
References: <CAGZ79kY=TP31VJxPZnjb04og-vHU+-c4d+AgAkis2Q7yeDeXbg@mail.gmail.com>
 <xmqq61d996oc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 01:28:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1OxG-0003OQ-4E
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 01:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbaLRA23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 19:28:29 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:61420 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbaLRA22 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 19:28:28 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so25473iga.15
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 16:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HbvG54KTqeDGxzZvZkfU4pb76wgi9d6kKcM8sgGf8d8=;
        b=mxfFMW/Gk6dtGKwpwOE25g+iBXug8D+voIgumcZ+GNkwy3swMd/losE8nlvdKu7w2+
         8K75TUDmcDM46g8TkrSbSmgiVv/4OpILcHo3egUOYxZInb+NXIn4ADN8NB/ImlCl470+
         zBJ/tpmXTM9ttArGFdydBYe4lNgGh+qiDh/FMCiMoP30H2K0sbFd2wLA+QrB3KxKPKbp
         xLhqKi9GtDXDRe9PvWxl7Wqa6FulmrF5Y4TWZEpC3gTNwspXbO1a4sYO6crOOr7YbDGi
         WcuZuPbfSBAOQW+D/dQtIgvGrHnsj29wK9BOyemDPI/qmI0Vm07id9ElupqfuqGteSuj
         xLmw==
X-Received: by 10.42.93.2 with SMTP id v2mr23091058icm.35.1418862508186;
        Wed, 17 Dec 2014 16:28:28 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c577:d193:b305:4b9f])
        by mx.google.com with ESMTPSA id bd5sm8571123igb.14.2014.12.17.16.28.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 16:28:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq61d996oc.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261512>

Junio C Hamano wrote:

> The issue is if some existing tests will be helped, if we had such a
> helper.

Since both bin-wrappers/git and test-lib.sh set GIT_TEMPLATE_DIR and
templates/blt doesn't contain any enabled hooks, I don't see how such
a helper would be useful.

If making things more consistent were worth the churn, then if
anything it would make sense to make test_create_repo private to the
setup code in test-lib.sh and to use plain 'git init <directory>' in
tests.

Jonathan
