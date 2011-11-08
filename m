From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Benchmarks regarding git's gc
Date: Tue, 8 Nov 2011 21:37:29 +0700
Message-ID: <CACsJy8DMAdjT8gsoSerkzNRvHgdcBWLaUd+-xHqXkV+hceo9rA@mail.gmail.com>
References: <CAMP44s3E-YCMQQzJAU2wjjD-adpNy6bGb-=iUQ=p=bFTWxm+Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 15:38:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNmoR-00077j-Dl
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 15:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546Ab1KHOiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 09:38:03 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60084 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab1KHOiB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 09:38:01 -0500
Received: by bke11 with SMTP id 11so444555bke.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 06:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WXT0wfkm6L1rROwaLlq4YDduSlGKZGCIBZM/qQiEIJg=;
        b=PqYU/QnctcVCfd42cBnI+3UgR3br1HdFT+J2GSV3cO42Vsse4q01ayCCoWZCcWxbUW
         eknYwKx7ek8dWUrbvVOgLGIWJi8v0kKiFL6HZ+IFFMpOyn6H7melVen8seChxfdfsrYg
         X40fTiJD8HnnLkkzdArVIA7WmYPs1v+825LNk=
Received: by 10.204.9.205 with SMTP id m13mr22716041bkm.32.1320763080125; Tue,
 08 Nov 2011 06:38:00 -0800 (PST)
Received: by 10.204.62.20 with HTTP; Tue, 8 Nov 2011 06:37:29 -0800 (PST)
In-Reply-To: <CAMP44s3E-YCMQQzJAU2wjjD-adpNy6bGb-=iUQ=p=bFTWxm+Ng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185089>

On Tue, Nov 8, 2011 at 6:34 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Has anybody seen these?
> http://draketo.de/proj/hg-vs-git-server/test-results.html#results
>
> Seems like a potential area of improvement.

The proportion between time and commits may have something to do with
reachability test, where we traverse all commits and trees (I think
twice in git-gc, one when it runs "reflog expire" and one "prune").
packv4 is supposed to make tree traversing faster. Although it'd be
best if we could avoid this test.
-- 
Duy
