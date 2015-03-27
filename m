From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/6] Memory leaks once again
Date: Fri, 27 Mar 2015 15:12:36 -0700
Message-ID: <CAGZ79kZ8=HoF0US0988oZxTyubjJO4vGYCtrUPX_x6gE0M2_Vw@mail.gmail.com>
References: <1427494150-8085-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 23:12:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcUb-0006qJ-PN
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbbC0WMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:12:37 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36138 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbbC0WMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:12:37 -0400
Received: by iedm5 with SMTP id m5so81275086ied.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A2Ok0tVzEJtqgkQvkmsgz0byXb+6wq0vH3KRZ+46P5M=;
        b=dwWlIUQf6hGOBV2Bzwo9+g96/6w3V8fI6OYW8BEboZ7Rydy3NKJyGqhlFVzqlZxkBE
         9zwOQ6qT00lm/F4OCUYfkNU1bg365Gmhz5bTOD4zXJEPnlvLR00qsNQUvSXWyEn3wVGb
         XIYyXEnp9/GPwoMZHDaOfuq/TmwSVSGBFDk5byL+FhIvu7D5QgHpKJGizw7jj8yfrMzV
         YGvla3+tWp31mAuug0eYziTx4SnF2VUXdRYd190rv++5GWtU6xusdAXqkQC2eB4QxGzX
         JqShn23V3qK1vSdFmiJSrzpmzhSzQELhBiXjiTd7m++t6ms0uJNvmQBx9hQDR3j2pqAM
         R21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=A2Ok0tVzEJtqgkQvkmsgz0byXb+6wq0vH3KRZ+46P5M=;
        b=YXqP+PnNHio4D3002T365SCJj4mUYYbQJEar67NvGHZnrI+ugpUwMSZ/8PTUnYWmpV
         MnL3y6ns4IvfEOu1vQhgcdN+J0JNv6gi5UJwyL8qOMKbxu1ilokr/x6yTnIqNdtbnrz5
         aX5qeTJGPTdljdjJ5aYTgCehFXRyzJeFB1PqSTLyUnrwwLkxXNVbUIh3t2x+wdabqQAm
         O8AZExx7E9WNRGnKbPAI96/MjC9STSw1uDD5JOoIu8IaPOpQpjhSuxcjoVpWR0oELvdu
         uJn3jmB+K4N2OzX5fv4y5TeW1GtBHzTe+kM85ZomZDp4uwDmevZeGkX+Zqn9V64Yi21I
         fqAQ==
X-Gm-Message-State: ALoCoQmJDlOG5u+bLbvDH3AJGBQzSD4OVOSai2vtWNJYVkTTum3S6Bfttldy4IlrJaOPy2eMYoRI
X-Received: by 10.50.107.36 with SMTP id gz4mr1500591igb.25.1427494356366;
 Fri, 27 Mar 2015 15:12:36 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Fri, 27 Mar 2015 15:12:36 -0700 (PDT)
In-Reply-To: <1427494150-8085-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266392>

On Fri, Mar 27, 2015 at 3:09 PM, Stefan Beller <sbeller@google.com> wrote:
> Here comes another bunch of memory leaks fixed.
> patches 1-4 are safe bets, but 5 and 6 are not so.
>
> In patch 5 I wonder if we need to fix more aggressively and
> in patch 6 I just know there is a leak but I have no idea how to
> actually fix it.
>

And I sent 12 instead of 6 patches because I needed to fine tune the
order of the patch set and I forgot to delete the un-tuned version.
