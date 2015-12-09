From: Taylor Braun-Jones <taylor@braun-jones.org>
Subject: Re: git-clone fails when current user is not in /etc/passwd
Date: Wed, 9 Dec 2015 17:35:52 -0500
Message-ID: <CAKfKJYuP1E5aC7SPO91j-KS-P41pYaM7NkTJ9uG6b=VvxbOBwg@mail.gmail.com>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
 <CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com> <CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 23:36:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6nLO-0003Ly-BL
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 23:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbbLIWgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 17:36:14 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33928 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbLIWgN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 17:36:13 -0500
Received: by qgeb1 with SMTP id b1so105167540qge.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 14:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=braun-jones.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=x195P2mIa9Ea/b8hNVrRnJKTsoF1E2LMEotA+9xyYXY=;
        b=chTDd2WM57vwh/JFankXkirCDhugTe/encdBl716l7HnYVwNEThek88arH2sm38Yz6
         K0SfvLMpAHw/6jJPpBykYYwbaxFDBvs/ZQUUIE53ryKOeW+UI65DAsmvjKX/DBAxc50w
         /f/dML2meb7CgydB0pOXwXRu40QEBhtbvXOSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=x195P2mIa9Ea/b8hNVrRnJKTsoF1E2LMEotA+9xyYXY=;
        b=DMspQl61qjUr0UULKYxd6J7SgwB9OYIECWi2AnVqBSQWLa2jdKJTjp+JlyR+P+xW2P
         8tKPJwyEfY6O7QHHZit4m7zCvysg9PskUT8IejY9PzI6P+bwnMItfiBnSeGDqj892YQ/
         oqSw22x80ytOEdeLd/gRnoA0UVYYry9nShrJvJUcbUgFiggImpX6+fwRrq55UmJOfMm9
         2Dtoq9b8l9mm+nBLEx3Tt/mJWcIlzNy2v6vw5JpLWvkIHbX+nfvNoIuhwQvI1wntYA4s
         IHQoRqWzvK0EUGrs6mlBdqVNeIzTCvnEmW9Ew/Wzq5f1l2qyJApGk4GJ4GID5n5v+hyh
         C6NQ==
X-Gm-Message-State: ALoCoQlIneo+OjnH7Tp757MAi0IurSqGscGsiOzdbeV3gVN8SOTE2t8+bM6ZIT5FDfnyyxEl6iy2VK0AkzoPz4st22cvWmCzgA==
X-Received: by 10.55.18.7 with SMTP id c7mr11054379qkh.33.1449700572583;
        Wed, 09 Dec 2015 14:36:12 -0800 (PST)
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com. [209.85.192.42])
        by smtp.gmail.com with ESMTPSA id h188sm4729647qhh.23.2015.12.09.14.36.11
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Dec 2015 14:36:11 -0800 (PST)
Received: by qgcc31 with SMTP id c31so105188714qgc.3
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 14:36:11 -0800 (PST)
X-Received: by 10.140.29.33 with SMTP id a30mr10568283qga.88.1449700571637;
 Wed, 09 Dec 2015 14:36:11 -0800 (PST)
Received: by 10.55.128.198 with HTTP; Wed, 9 Dec 2015 14:35:52 -0800 (PST)
In-Reply-To: <CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com>
X-Gmail-Original-Message-ID: <CAKfKJYuP1E5aC7SPO91j-KS-P41pYaM7NkTJ9uG6b=VvxbOBwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282204>

On Wed, Dec 9, 2015 at 1:24 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Dec 9, 2015 at 5:08 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, Dec 2, 2015 at 9:10 PM, Taylor Braun-Jones
>> <taylor@braun-jones.org> wrote:
>>> My use case it running git clone inside a docker container with
>>> `docker run --user $(id -u):$(id -g) --volume /foo:/foo ...`. I want
>>> all /foo/* file creation/access from inside the Docker container to be
>>> done as the current uid/gid of the host system.
>>>
>>> Steps to reproduce:
>>>
>>> mkdir /tmp/docker-git
>>> cat > /tmp/docker-git/Dockerfile <<EOF
>>> FROM ubuntu
>>> RUN apt-get update && apt-get install -y git-core
>>> EOF
>>> docker build -t git /tmp/docker-git/
>>> docker run --user $(id -u):$(id -g) git git clone
>>> https://github.com/git/git.git /tmp/git
>>> # fatal: unable to look up current user in the passwd file: no such user
>>
>> It probably helps if you could get the stack trace to this message
>> (printed from function xgetpwuid_self). I haven't checked if my
>> personal laptop has docker to reproduce this.. In general we won't ask
>> passwd if the user specifies name/email in the config file. But I
>> still don't see why git-clone needs that info in the first place.
>
> Well.. reflog needs it. So either you disable reflog at clone time or
> define name/email via config file. I don't see anything wrong with
> this behavior.

Can't git just use "unknown" and "unknown@localhost" if the name or
email can not be determined from xgetpwuid? This seems to be the way
that Mercurial behaves.
