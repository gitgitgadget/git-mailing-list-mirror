From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/3] interactive git clean
Date: Sun, 5 May 2013 08:35:55 -0400
Message-ID: <CAPig+cR--LQSkxc27_tMRrEnFJFApymqK9268BQA0bab38W3OQ@mail.gmail.com>
References: <cover.1367551846.git.worldhello.net@gmail.com>
	<CAPig+cQALgr_VXwG5jBiFVTM627se8zQz7vsmF=A9OLcp_GT9A@mail.gmail.com>
	<CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 05 14:36:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYyAh-0001EO-Lx
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 14:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab3EEMf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 08:35:56 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:63735 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab3EEMfz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 08:35:55 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so3241713iea.18
        for <git@vger.kernel.org>; Sun, 05 May 2013 05:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=3fBTTGBLrDKsQZNBrpWwUAoaraDiu8QuqnSqX+x4k00=;
        b=RJKLfmRJlN2ZhBiq3g0fgA58NM+yNkGEJWSpfSm1ID+lCXCJbCjFbhVLHQkvT/niq6
         4FPQdD7e3fqWq09bazcxj9ghyWMUXN1A2Jq6nevH+tnkxEWtZwWwsv/dNxU6b7Vx44WM
         Cy3JRhswcjyaoydHd/IRrhWy1RPKNUKtBvMpU1yC9Z+SygbpTA8U4b9uANceyVW+a6ZK
         8nZNb2sSDtRZXR/oiTM3W5JRR7/+GGhEz9c520FmL23u+fh2afcybrwJRChpjBollH1a
         fKBVNP/v7u+MQg/YE1d10Kig150TuOUHwQHWbj0+zJEwCoERr/8vVcVIOLgkeSRtWHSY
         HD6Q==
X-Received: by 10.50.1.69 with SMTP id 5mr1443596igk.100.1367757355254; Sun,
 05 May 2013 05:35:55 -0700 (PDT)
Received: by 10.64.13.46 with HTTP; Sun, 5 May 2013 05:35:55 -0700 (PDT)
In-Reply-To: <CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com>
X-Google-Sender-Auth: 8jgM1V64ENmR8Cc_JzCdJKYN7kQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223399>

On Fri, May 3, 2013 at 9:06 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
> 2013/5/3 Eric Sunshine <sunshine@sunshineco.com>:
>> More generally, is this sort of modal edit mode desirable and
>> convenient? Can the edit operation be combined with the top-level
>> prompt? For example:
>>
>>   % git clean -i
>>   file1 file2 file3
>>   file4 file5 file6
>>   Remove ([y]es, [n]o, [p]rompt, exclusion-list)? file[4-6]
>>   file1 file2 file3
>>   Remove ([y]es, [n]o, [p]rompt, exclusion-list)? p
>>   file1 (y/n/q/!)? y
>>   file2 (y/n/q/!)? n
>>   file3 (y/n/q/!)? y
>
> What If there is a file named 'y', and the user want to exclude it,
> and press 'y' as a pattern.

The pattern [y] will match file named 'y'. It probably is unusual for
files named 'y', 'n', etc. to exist in the top-level directory, but
the gitignore patterns already provide an escape hatch for these
unusual cases. (That is not to say that this is the perfect example or
solution, but only that it may be worth considering such options when
designing the user-interface for convenience.)
