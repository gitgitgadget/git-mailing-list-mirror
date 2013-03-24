From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Fix revision walk for commits with the same dates
Date: Sat, 23 Mar 2013 22:18:49 -0400
Message-ID: <CAPig+cQjkE1PcfpsaAEYDq8zaLzQTEY_4j8B-Fp0=7=EnosFfw@mail.gmail.com>
References: <20130307180321.GA26756@camk.edu.pl>
	<20130322183819.GA18210@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Sun Mar 24 03:19:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJaWl-00056T-Ck
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 03:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab3CXCSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 22:18:51 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:64741 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab3CXCSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 22:18:50 -0400
Received: by mail-la0-f54.google.com with SMTP id gw10so9500929lab.27
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 19:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=QUK/AV8QnLmUjZbgSGDzZqfekONtL7CPb/hVdhQfTwM=;
        b=C1yQkjvhmDCCmk0M8E/MpDyMESFBj09/VCVUTONgM5du7eKhGYyVCW0mkKOUSWjmCY
         nD7CkLrRHoa+HB0i31fZrYkijJN679uhnZDn7BnKuxOT55GdzqCND1MWQrLthUCzPALl
         kOstiV+3Ou3p0VWjjnpGVV3/dSyIWxbIaIdz/Ua9qMQqwc6pRVgQ6tOnjPOXBrOu8xFy
         P2hL/76nDEb6oEr1bk8MP3h/tRZcqA+MUoqr1qVtoXSAQ3oh7+xZip6xnbzTn9wK+PXM
         uK4N4kIThIwTD6L4W67hOs3eaEhWSt3JVxKsznA9rVzJEk+5PBSik+YEFgqvjEVnmv8Z
         D3Ag==
X-Received: by 10.112.146.133 with SMTP id tc5mr2694561lbb.88.1364091529283;
 Sat, 23 Mar 2013 19:18:49 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sat, 23 Mar 2013 19:18:49 -0700 (PDT)
In-Reply-To: <20130322183819.GA18210@camk.edu.pl>
X-Google-Sender-Auth: DLtKk68fCyCa13x6Yknktkmp5lg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218928>

On Fri, Mar 22, 2013 at 2:38 PM, Kacper Kornet <draenog@pld-linux.org> wrote:
> Logic in still_interesting function allows to stop the commits
> traversing if the oldest processed commit is not older then the

s/then/than/

> youngest commit on the list to process and the list contains only
> commits marked as not interesting ones. It can be premature when dealing
> with a set of coequal commits. For example git rev-list A^! --not B
> provides wrong answer if all commits in the range A..B had the same
> commit time and there are more then 7 of them.
