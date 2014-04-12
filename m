From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically
 update it
Date: Sat, 12 Apr 2014 07:10:18 +0700
Message-ID: <CACsJy8ASAvopmyhawmUkuFk4DjBd2opL1kxu_jtopTDr80BWPg@mail.gmail.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com>
 <xmqqppkpvv9m.fsf@gitster.dls.corp.google.com> <CACsJy8A5VJM4gnJGazkzniv5YxRx0xR7YEFpQbU+kVGofQ1b_g@mail.gmail.com>
 <xmqqtx9zsm8p.fsf@gitster.dls.corp.google.com> <xmqqmwfrr3zw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 02:12:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYlYG-00042P-9b
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 02:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933AbaDLAL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 20:11:29 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:61184 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbaDLAKu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 20:10:50 -0400
Received: by mail-qc0-f180.google.com with SMTP id w7so6808532qcr.11
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 17:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aj7dIbgM+0bXyMJdf6n3hrcHNpghBbR+D/nFlFsn9og=;
        b=XODg9BueZIsi5iCTRNJnqCEHg8QhNRELXsuFvmDla2m8RhmlIjt1DSEQdc9BEqCu26
         yVoADN78yYIO0cXd5/sPikhXnlT41C14LYhlRor50NPEuy5F7ak6fS6STo8KOKYLyjHO
         LYZZaQMaYUpOhvyb+vMzX9LHoGkOJ6xX7vOvLjHjx0pWrt4BaLA5GM2g6njaAXKjLASr
         G7ABx/4WBGlJtOE4aZi1HrqlvZhi4bdQQ3XCwqR4AIOOKcF8SekqpwrGrQwlBIuGipuz
         LuDxMd8+FohLCkPL+cFcLo8xMosKxUwzyVJB6IdoVz0S6XC+PN+9IKX+gzamI6455iGl
         q8KA==
X-Received: by 10.140.82.167 with SMTP id h36mr32070473qgd.51.1397261448954;
 Fri, 11 Apr 2014 17:10:48 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Fri, 11 Apr 2014 17:10:18 -0700 (PDT)
In-Reply-To: <xmqqmwfrr3zw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246160>

On Sat, Apr 12, 2014 at 3:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Having said that, nobody sane would be running two simultaneous
> operations that are clearly write-oriented competing with each other
> against the same index file.

When it comes to racing, sanity does not matter much. People could
just do it without thinking what exactly is happening behind the
scene.

> So in that sense that can be done as a less urgent follow-up for this topic.

Yeah if racing at refresh time is a real problem, sure we should solve it first.
-- 
Duy
