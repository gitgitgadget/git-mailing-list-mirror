From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] imap-send.c: implements the GIT_CURL_DEBUG
 environment variable
Date: Wed, 6 Apr 2016 01:53:35 -0400
Message-ID: <CAPig+cSR6CQ6Q=TOaTgqwC0nOkB_khDLevWDPZsOwKbGrjptKQ@mail.gmail.com>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
	<CAPig+cRrmdiz4fHAX3xg6CinSOPBv207RZLaacRBkoDNHLaPwA@mail.gmail.com>
	<CA+EOSBmL8oHo_wWUzyBq=4Z7fFoFj5Gnf7UveOyiNMS3yhH8Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 07:53:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1angPT-0006FC-8Q
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 07:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbcDFFxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 01:53:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36067 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcDFFxg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 01:53:36 -0400
Received: by mail-io0-f193.google.com with SMTP id s2so5727101iod.3
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 22:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=kGaTdPjqnJ6sPQyj/b7UUmPcCXJaprCg4nHm+PSFeds=;
        b=D8wqlZJS/rFudm2l3XIaiV23812HieUMG1pySL5z/tCPY99HjlyBF5WwUHUfWe5AYt
         Hcx+yVnjHtJ9QALvLnIHcYDHkzZ5v4JWOt33pHNCeZYb/h18CCMsmfVXUweis33ixr7z
         /6GXUe9cDPDYEAUDQxmz1D0+g0/Kp4fGJDMhaBbn1gPcznq8O7Y+V9ucGLHmeeYT8BIs
         4Flzepz4QV24N47Kk06Dkf1rWHF/9I0j1bbVaaMjv9pMKBzrXXoT7je2pKDMdx1g5Cgu
         Sj+Kn9xy7bQOYy4d3aB+wvzGpOX/6JJl8L/M72MGj9lda5QDcQN+qNWCg1EsGl8AHSOO
         9gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kGaTdPjqnJ6sPQyj/b7UUmPcCXJaprCg4nHm+PSFeds=;
        b=bfpX0aXLyc842K7zcg/bgNtXFVT/+2R7F6vib4u24aot1SvcoSg3jWLA1Pc0H63f3d
         73efAkTezJuWKdr94qXx3jaXlvTTri/GYBn87M6mLq70FUzBlq0fuRmnpNrRkZqiy9zL
         uQk7brbZg3er6BGUCz4hqDNNSWa4ncjWqLSNvAAUPYpLYXLwgm4qWFX9BMH6ssPW1lA3
         BJXK5caYEQD3VI0DP5KwUONQ+iqveCjS0qDXCK36KZonT2fohah1kTeBxotMXnqs+Gf+
         aCTIlEuSyZHo1cZE2Kr9WJ118k7rOa6Sq0tyK/vwb2N5CNqSTstAGdls1tIQ4juoa8ae
         Jy7w==
X-Gm-Message-State: AD7BkJKmrFK0c07QDroJswkolaLzWC0E6s8XSJPkCPq7UG9wvuaMAZYJ58BmRZYt5L3cTtTz7fpL7t7b8q+ewQ==
X-Received: by 10.107.8.141 with SMTP id h13mr4395806ioi.34.1459922015149;
 Tue, 05 Apr 2016 22:53:35 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Tue, 5 Apr 2016 22:53:35 -0700 (PDT)
In-Reply-To: <CA+EOSBmL8oHo_wWUzyBq=4Z7fFoFj5Gnf7UveOyiNMS3yhH8Uw@mail.gmail.com>
X-Google-Sender-Auth: qRwWsaLHi65JC4_v7DDvPubGL7c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290820>

On Tue, Apr 5, 2016 at 6:21 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> 2016-04-01 22:25 GMT+02:00 Eric Sunshine <sunshine@sunshineco.com>:
>> In addition to review comments by others, why are the new curl_dump()
>> and curl_trace() functions duplicated in both patches rather than
>> factored out to a shared implementation?
>
> It's right. Do you think i can use some existing file or should I
> create a new object file ?

Peff or Junio would be more qualified to answer, but perhaps the
shared implementation could go in http.c?
