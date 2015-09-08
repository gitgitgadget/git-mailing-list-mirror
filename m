From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3 0/5] git-p4: add support for large file systems
Date: Tue, 8 Sep 2015 05:25:33 +0100
Message-ID: <CAE5ih7_9CfGw51Aw8J8d2m=s3Z9sf8LV9p84SynrpCW4k0Vbxg@mail.gmail.com>
References: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 06:25:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZATg-0003vG-Lu
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 06:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbbIHEZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 00:25:35 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36320 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbbIHEZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 00:25:33 -0400
Received: by obqa2 with SMTP id a2so73953296obq.3
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nf9AcluvY3ODqKmX2i5BIeeuWzEHf6VzJ2wMIPr1VyU=;
        b=EB0+Uv3zq6ZaBQtpsX73NhKsrkgG53AdagFsq4wkz9yEDeq8moOQA9qwbJDId5IAJB
         wR9w8z8QR2Oj22oW/QznaWOmsPVrFA1z4xE0hvQ5rXPh58oT16l8QUEfcdI7H/+PtqvF
         IOChcJsAnScgA/PlsnVkvwbaGLJo4D4XwVM3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nf9AcluvY3ODqKmX2i5BIeeuWzEHf6VzJ2wMIPr1VyU=;
        b=InCuw6AD8oX+l6yRApnatAUrrqRS6KywSiRjAnKiIuCqmIuB6Tqqy8YhGx9a06j1M0
         dHiOJZzED0FSToA8Jtrga8o4/MgWFGT8SpYb2pfJ8VM4NP7VJNYmdMNhaDG6xxKC7K7i
         T/PIaUMAhaGQC0Bail4qAdugtekGm/O/Ff5xHnbjFm5T7PdGlzSdWRYq6qt2wOW0fIj4
         HHKjwE7R/5lmjjynlSAlkuD7y6nXHKJKvZDRjJNXCtA0kVzUXhmFctl5arXbwEF6wb1A
         SkWOuwJjhkZargox1W+ox6ZQX7fS44jSbtI0LMyhhHZV73KAdJy8RDtk1TVCSFOaCLY6
         kWlw==
X-Gm-Message-State: ALoCoQkYdf+2YEcscr3RmkdnOsTfiGD8hH2kvuW06sU/QIz9lWgIoeL5uO+VU42h139tcH5DwlI+
X-Received: by 10.60.67.105 with SMTP id m9mr18394222oet.68.1441686333195;
 Mon, 07 Sep 2015 21:25:33 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Mon, 7 Sep 2015 21:25:33 -0700 (PDT)
In-Reply-To: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277483>

On 7 September 2015 at 13:21,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> One thing I don't like about the current implementation is that I don't see a
> way to test the "git-p4.pushLargeFiles" config. I could start a git lfs server
> locally but that seems a bit too much, no?

Perhaps add a trivial large-file derived class that just does enough
to show that it's all working. Then the final bit of pushing the large
files to LFS would remain forever untested, but it would be small
enough and simple enough not to be a real problem. If it ever broke,
it would indicate that either the trivial test class was a bit too
trivial, or that the abstraction was not abstract enough and there's
too much common-code in the derived classes.

Luke
