From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Tue, 20 Nov 2012 20:17:35 -0800
Message-ID: <20121121041735.GE4634@elie.Belkin>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
 <7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 05:17:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb1l5-0003L2-QT
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 05:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab2KUERl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 23:17:41 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38896 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab2KUERk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 23:17:40 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so4777593pbc.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 20:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Kqo52xWJgeNuQsc3G8Q+XFrznGUHHs+XTobuY0kJu+A=;
        b=YNwjfndt3nsysSp70gy7dh5sVeSk4jPJsl+ukhx7bQh3u8IjKG0SaHDoPmm4zsaVv1
         dqCzOZg1BeBER3dD9poc7Hr3n9MMviMEuw42iJqE2r0wSluZzp6gDsHzNBxP0tpId/EZ
         A9/00ElbhLk+cnP4RiLwbwlR32TFgxqMAPtNCNElmnz1ppjHaj2hS9iAIFBgZnipbKE2
         5veEkmVTAoBCtqPyJU5xGYx4H3PSJMgDR8oRJoPjVtKDziZ29Fmmm/pW7G3W12uisMCS
         hQZz38yjy3YaVsjvJXVJ/a3eK/A504aqto3L/etSWjhYcNGoHjwqHaSuydrcBYZFBL86
         6sPQ==
Received: by 10.66.76.73 with SMTP id i9mr14284689paw.17.1353471460526;
        Tue, 20 Nov 2012 20:17:40 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id xk2sm9180607pbc.45.2012.11.20.20.17.38
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Nov 2012 20:17:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210133>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Of course, transport-helper shouldn't even be specifying the negative
>> (^) refs, but that's another story.
>
> Hrm, I am not sure I understand what you mean by this.
>
> How should it be telling the fast-export up to what commit the
> receiving end should already have the history for (hence they do not
> need to be sent)?  Or are you advocating to re-send the entire
> history down to the root commit every time?

I think Felipe has mentioned before that he considers it the remote
helper's responsibility to keep track of what commits have already
been imported, for example using a marks file.

Never mind that others have said that that's not the current interface
(I don't yet see why it would be a good interface after a transition,
but maybe it would be).  Still, hopefully that clarifies the intended
meaning.

Hope that helps,
Jonathan
