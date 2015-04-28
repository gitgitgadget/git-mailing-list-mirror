From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCH] git-p4: add failing tests for case-folding p4d
Date: Tue, 28 Apr 2015 19:01:46 -0400
Message-ID: <CALM2Sna0OqxYWzEj94SY61ZsL8cB+SyuiJ0EsAzq+kbiw87QLQ@mail.gmail.com>
References: <1430212081-16146-1-git-send-email-luke@diamand.org>
	<1430212081-16146-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 01:01:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnEVm-0007Kf-5X
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 01:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031206AbbD1XBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 19:01:49 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34563 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030957AbbD1XBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 19:01:47 -0400
Received: by pacyx8 with SMTP id yx8so9306009pac.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 16:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=k6Fj9LyUPQzFeQ4CACK5N4zEAw0Qxz09DFkvBBxoZ2U=;
        b=wHHXe25GrVvxxbiHHWI5Mi6qfJCzkgPuQtCYf6946szLFAytYvXGnmZ34AgRmuJ231
         oJ1iKP9MtNd1TMBgVYsNLfuF1efj6TLx4NBJz4PBGtYuKRe5E0/rlYCTok6JiODIQ8kn
         86H0LIum+oGw0LDdIbpwoeywA9N4z9M9LYKzwA6F+9Bn0cgVqiuwB2lZCECO1zDWgXeD
         CMUT+w5dpXbS1HRf5Yv9cwYrdKMnUtkw4SNrMzJgE0LQG6y+PWSEs35h13MCCNMUvMC2
         gZvDn1bwcISZUDhL8Q8sZkGOh6v+xYLcD+S3zRw1Gpws5m/SxVgwnrX0RtMveZhOt3mm
         wBgg==
X-Received: by 10.66.229.9 with SMTP id sm9mr36509797pac.1.1430262106702; Tue,
 28 Apr 2015 16:01:46 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Tue, 28 Apr 2015 16:01:46 -0700 (PDT)
In-Reply-To: <1430212081-16146-2-git-send-email-luke@diamand.org>
X-Google-Sender-Auth: IZnHTTZgPzubm5K4l6uUd0Hy__g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267947>

The last comment in the test took me a minute to decipher. I would
suggest "no repo path called LC" instead of "no repo called LC". Also,
it would have helped me to either have a little comment on the "UC"
version of the test, or to make the previous comment a little more
neutral so that it will apply to both test cases.

Otherwise, while I am not a regular maintainer of this code, the patch
does LGTM. Certainly it's good to have more test coverage.

For the underlying problem, I haven't thought about it very much, but
it looks like a plausible first step might be to simply probe the
given file name and see if it comes back the same way. If it comes
back differently, then maybe the command should abort?


What a tough problem all around...

Lex
