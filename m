From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] safe_create_leading_directories(): modernize format
 of "if" chaining
Date: Thu, 26 Dec 2013 13:52:25 -0800
Message-ID: <20131226215225.GW20443@google.com>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
 <1387696451-32224-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 26 22:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwIr4-00028Y-JA
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 22:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab3LZVwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 16:52:30 -0500
Received: from mail-gg0-f181.google.com ([209.85.161.181]:54400 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab3LZVw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 16:52:29 -0500
Received: by mail-gg0-f181.google.com with SMTP id y1so1785427ggc.40
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 13:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GUBz5fgFr0p8Ywcc7wHjm4Eo+3vwcAo0jkBCtdtzAws=;
        b=SP0YEVyWq1WLxkf5jzjuFyNtcMu+Xd6ByXfJ2UwpiJl+JO9xWEdJPMBOjtrA/KHuBy
         SzwKHvZzCmckz3ydG4cv2rtsXDhASezbuFbeyIubx2hppcXNOQlMQMpslFhDTYfGnZkf
         wYJLPJX7bx51zsnJjT2KbndT0+LVS3uA5Lqh0bmeVS6dsx9WoQ/ZFMcOkld0QMGhAu9y
         Xu8EepWkdSTlQ+noAXfhJhz/IlA/6NZFVk4QL15fdzVMfOI7fYV8XpaqSHKzne0CIB05
         ucP3NYlU6t6yfF1sRsg73jKmRlWgzVgUmXbpupViieH+gQU4UEGdi3TH5nXRT6j4oXO9
         89EQ==
X-Received: by 10.236.37.105 with SMTP id x69mr30605597yha.15.1388094749290;
        Thu, 26 Dec 2013 13:52:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id s21sm43464559yhk.9.2013.12.26.13.52.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 13:52:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387696451-32224-2-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239714>

Michael Haggerty wrote:

> [Subject: safe_create_leading_directories(): modernize format of "if" chaining]

Trivia: it's not so much modernizing as following K&R style, which git
more or less followed since day 1.  Linux's Documentation/CodingStyle
explains:

  Note that the closing brace is empty on a line of its own, _except_ in
  the cases where it is followed by a continuation of the same statement,
  ie a "while" in a do-statement or an "else" in an if-statement, like
  this:
[...]
  Rationale: K&R.

  Also, note that this brace-placement also minimizes the number of empty
  (or almost empty) lines, without any loss of readability.  Thus, as the
  supply of new-lines on your screen is not a renewable resource (think
  25-line terminal screens here), you have more empty lines to put
  comments on.

Here it's especially jarring since the function uses a mix of styles.
Thanks for cleaning it up.
