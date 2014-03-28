From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Found a "bug" in git 1.9.0 but can't reproduce it without
 copyrighted source code.
Date: Thu, 27 Mar 2014 18:40:22 -0700
Message-ID: <20140328014022.GO15625@google.com>
References: <CA+fYBFdzC-_B2Qfk8Hg0pLUNy4oayySs+8B3vWq7uuBeAx9eJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: yun sheng <uewing@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 02:41:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTLn6-0006uq-DZ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 02:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054AbaC1Bkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 21:40:49 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:51115 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757066AbaC1BkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 21:40:25 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so4160402pde.10
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 18:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gHLFPt6/hwsGtiZ9by/dySwtzUEFRfBzvRL1ryEYiLg=;
        b=vlyHeuyG0tS4SPBrW7W9+vwQbB0uvb1ntyE+iXrJ++ULAQpDpBIvhRqa3oIGuIHkz0
         Y1k7cyCZqNV19L/pum0GGqsRL90Vv/1bI+Wdt3YtqJHkOr4bXz7Nyf4mJ3SC8Wei6zyk
         r3cjBgUK6x4cbTvQccY5edt6VKRSYtjLvyb1/r7C151Zp14DrgZ4lXPnn0SuVOTI1tbW
         YLUhGS67zJNpkPs4XJb3lAQ2B7G0SUTIAhxvpb3MRS4fmEMKKLVZt5JQ3P8I1kYBngT7
         EnXvLaO9OL6OSS4kukHlxc7YWohXQNKkky9W5STnytPXWEb2q8aopgWxE4PwPZqq9D/r
         uV2w==
X-Received: by 10.67.5.7 with SMTP id ci7mr5179043pad.99.1395970825424;
        Thu, 27 Mar 2014 18:40:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ha2sm15499862pbb.8.2014.03.27.18.40.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 18:40:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+fYBFdzC-_B2Qfk8Hg0pLUNy4oayySs+8B3vWq7uuBeAx9eJQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245348>

Hi,

yun sheng wrote:

> these two files have the same timestamp, the same size, bug slightly
> different contents.

How did they get the same timestamp?

[...]
> Git I'm using is msysgit 1.9.0 on windows 7

Unixy operating systems have other fields like inode number and ctime
that make it possible to notice that a file might have been changed
without actually rereading it.  Unfortunately Git for Windows is
limited to what's in the WIN32_FILE_ATTRIBUTE_DATA which means the
size, mtime, and mode are basically all it has to go by.

Do you know of some other Windows API call that could help?

Hope that helps,
Jonathan
