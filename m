From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Pushing/fetching from/into a shallow-cloned repository
Date: Fri, 19 Apr 2013 21:22:00 +1000
Message-ID: <CACsJy8DUZYuGO=4WL-uyszxvhvwyuz4=SvW6O0O+5O+XZUfDmg@mail.gmail.com>
References: <20130418135233.87aa23896fa48dc2d87d80fb@domain007.com> <8BCCECD4CEEA4028AD97B851099F4C5E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Apr 19 13:22:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT9On-0001om-1H
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 13:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968057Ab3DSLWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 07:22:33 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:35656 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287Ab3DSLWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 07:22:32 -0400
Received: by mail-oa0-f52.google.com with SMTP id k18so3655534oag.39
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=HTBPvoADtMqqzYy+ZO4WpZT4gZna2Oniv2JzoBZv+gM=;
        b=ZNFDAAcnxLnoVccRkNIlp/VVI4SoJBob/K8AGfpJ7w9NsUncTluwHHPULem0poOnxV
         WT+y/5zWDNS/pYakTrcjvB0QVbCjuV03nWlddTZSRtdtJm9w9j6jfMa+AzE7OHjKaKT4
         VWaF3vaaRwGCp9W2HP+3HL75jSgWlT3uzqXgesV5vdzsZtOKHyW4e8mAJl+96SqSlpf2
         /e3pnlLSXik+M+ZUzJUeOZl/kEdkBHFVHG3IIZEZcT84euUOzGqGtLf5yiR1YG9Jr2jR
         6iLySdYKbMIuYHwHztMKwG0panTf8sqBxaFZ+NGdOfv1+h9ECrukvxqVcHLC9MdQU/s4
         T4+A==
X-Received: by 10.60.142.230 with SMTP id rz6mr8617264oeb.22.1366370551781;
 Fri, 19 Apr 2013 04:22:31 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Fri, 19 Apr 2013 04:22:00 -0700 (PDT)
In-Reply-To: <8BCCECD4CEEA4028AD97B851099F4C5E@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221756>

On Fri, Apr 19, 2013 at 6:27 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Konstantin Khomoutov" <kostix+git@007spb.ru>
>> So I observe pushing/fetching works OK at least for a simple case like
>> this one.
>>
>> Hence I'd like to ask: if the manual page is wrong or I'm observing
>> some corner case?
>> --
>
> The manual is deliberately misleading.
> The problem is that the depth is a movable feast that depends on how far the
> branches have progressed.
> The DAG will be missing the historic merge bases, and in some scenarios can
> form disconnected runs of commits. The ref negotiation can also be a
> problem.
>
> The git\Documentation\technical\shallow.txt has some extra details on
> issues.

With recent improvements in index-pack, I think we can be certain that
all gaps are caught. So either it works or it does not. It cannot lead
to an incomplete repository. At least for git and smart http
transports. So I'm inclined to lift the limitation for these
transports. Missing merge bases remains a limitation the user should
be aware of, of course.
--
Duy
