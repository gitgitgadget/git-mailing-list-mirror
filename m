From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG?] gc and impatience
Date: Sat, 3 Aug 2013 07:18:20 +0530
Message-ID: <CALkWK0k2B5OW9zMrw0jBDDWpufojYDJybXa7jCBdzftNUc7mxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 03 03:49:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Qxv-00070D-4B
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 03:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404Ab3HCBtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 21:49:03 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34120 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216Ab3HCBtB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 21:49:01 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so2448104obc.3
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 18:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Ak5zL+KtgLXafxnKtsATaL8BofVBQMx1qD681lQzmyE=;
        b=rtUZiOtK7jLhEmRoo3wytwsYrw0dOM7cHN+F+ZT9B2yyzceLKatzey8ePFMxDDC1iB
         OAIbXICVeMW+J01jZD5A59QpAvu13Oxuw9zQ+YCayTlReHoVG+aw8ggvtEj5SF66FIjr
         Pz3fw0DuFv3cfRPRCkntsYb+R90mSj4bDo8uWkilv077GnScRuDyWGNjGQ6vRDlXqyLx
         1mZMaN7/NRxh60eY/kwGbTnLQOozVlA6quDA12HU1ge0208VT0VHBfqDKczrYaWFzod1
         zvNwZbP6qf9PIBMUYgTz+5rv9KVxMJ8DKR4hg0ewwr0A1U4xytzffXhuEKU+lTINzaNm
         +3KQ==
X-Received: by 10.50.134.9 with SMTP id pg9mr164849igb.29.1375494540603; Fri,
 02 Aug 2013 18:49:00 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 2 Aug 2013 18:48:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231555>

Hi,

I was pulling in some changes in the morning to find:

 Auto packing the repository for optimum performance. You may also
 run "git gc" manually. See "git help gc" for more information.

Being my usual impatient self, I opened another prompt and started
merging changes. After the checkout, it started running another gc
(why!?), which I attempted to kill using ^C.

  Counting objects: 449291   x$

It didn't just fail to stop, but it kept writing output making my
prompt completely unusable. I finally just killed the pane. Now, it's
struggling to update-index and update my cache (read: more waiting).

Why is gc not designed for impatient people, and what needs to be done
to change this?

Ram
