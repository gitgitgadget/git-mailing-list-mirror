From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] upload-pack: ignore 'shallow' lines with unknown obj-ids
Date: Sat, 20 Apr 2013 20:34:41 +1000
Message-ID: <CACsJy8B6OYC-Qcwc53BsVtUSHw1ag6LWF2rBSP6agO6yTXQo+g@mail.gmail.com>
References: <CAJDSCnN6Ekp3wF9hX9Dbt3+CLNg1_aBz8nPGUuCu0WS9MF8aXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Heemskerk <mheemskerk@atlassian.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 12:35:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTV8e-0008BU-1H
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 12:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954Ab3DTKfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 06:35:15 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:43528 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942Ab3DTKfN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 06:35:13 -0400
Received: by mail-ob0-f180.google.com with SMTP id un3so4260184obb.11
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZGDoqYn/yCmLVeAhY/ORRm7Q0zbrI/C5NxhFdHNLrNM=;
        b=JsAWYtlYK4cBF67JTpaY99hSh0ggYOZHQ6+T7zusjxRbeLK0DbHoOzEwgih64/6zM/
         O0FOWHu952hI6U4XKTHIwdJpOJ6B179V157bS5e+TL4aGZVZEL+cEfoSmvZPC8ppuihp
         DHRbmycg5bELHrS3YQ3zWyTWagqH8dKzMymYE2U4eI/DCCNkJNJ3kk7GQxeWgWZO+5ql
         YgV1DWIlHSww0SSnwRKct5auqdYNZtioLOy4GbNNegv/5O4AHNyDzatrm+fYCo69Zhxh
         HSuXNU/ZST1/wQNyruXW6n/w3FRFPWAprgbms05it0nPI6I11l6/9jPj+bsfZnOwwtGC
         2K+A==
X-Received: by 10.60.135.103 with SMTP id pr7mr6030267oeb.142.1366454112312;
 Sat, 20 Apr 2013 03:35:12 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Sat, 20 Apr 2013 03:34:41 -0700 (PDT)
In-Reply-To: <CAJDSCnN6Ekp3wF9hX9Dbt3+CLNg1_aBz8nPGUuCu0WS9MF8aXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221842>

On Sat, Apr 20, 2013 at 8:05 PM, Michael Heemskerk
<mheemskerk@atlassian.com> wrote:
> When the client sends a 'shallow' line for an object that the server does
> not have, the server currently dies with the error: "did not find object
> for shallow <obj-id>". The client may have received the object from a
> different server, or the object may have been garbage collected by the
> server. In either case, the object is not relevant for calculating the pack
> that is to be sent and can be safely ignored.
>
> The documentation in technical/pack-protocol.txt has been updated to
> remove the restriction that "Clients MUST NOT mention an obj-id which it
> does not know exists on the server". This requirement is not realistic
> because clients cannot know whether an object has been garbage collected
> by the server.
>
> Signed-off-by: Michael Heemskerk <mheemskerk@atlassian.com>

I'm not an expert in git protocol (or shallow extension in particular)
but the reasoning sounds right and the implemention looks correct.

Acked-by: Duy Nguyen <pclouds@gmail.com>
--
Duy
