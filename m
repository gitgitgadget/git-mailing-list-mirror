From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Code reorgnization
Date: Thu, 17 Mar 2016 11:37:39 -0700
Message-ID: <CAGZ79kbcwFcPSJ9xwE6xi4gQ871m3brtfAut2TChGNzL-foxdQ@mail.gmail.com>
References: <20160317111136.GA21745@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:38:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agco5-0008Rx-58
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031023AbcCQSho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 14:37:44 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37059 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936495AbcCQShk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 14:37:40 -0400
Received: by mail-ig0-f182.google.com with SMTP id kc10so3907442igb.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=uLZ9u84TXnpA8uvFj5kvSzjlY4uGf7neEHcMtL91LzE=;
        b=X85NoDVAAQRhYtPihJJMcD1b+SijSxm3VaHi6iayFY6e1xah8QnMclzW70osyTHiA9
         Y3dSNfIzXv7NB8UUd3NMRU95FX3hAT22Pm0OR17gF1+M3AE/RkWbnjNSHKCWZjTey43E
         cOAiVOntxbRCkKzlSZeL1BzrQbl4OBw2WWByP01J/JdUR+Tyv4Iu0IXlpTPB+I++8+0w
         xMQk2UkD3p8nuH73pcRDEZLuFQRzeeWuej1LemzkrfDsuEPRWTSB6Inv6KqiL4uycxM4
         SdbjOB/a3Sr93Cxl35nE7Uwz/p0VIbgccEY8oVQQRIj9eslSKMc+i5zEvhi5t4uM8byZ
         YxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=uLZ9u84TXnpA8uvFj5kvSzjlY4uGf7neEHcMtL91LzE=;
        b=nM5qIpeEtqW3RN11RWgHp9LDr7cnzJNeNMDNMw/5WNJtC9uXFv/teUvOrDg4YmFyDr
         yJPV1D+6JZpKc6djXfvrifbA00yuoazLGMPSGYaBIybtql85RxhHSOo+yEo2+mRSZ8e0
         0sqIycmtohyApoHtA4F5btmSgAJlOJmaNM6D5V6Zu/5Xf0JnDMMyYVw/FIafgutUmcx5
         KBy9HE79EqgKwDaMo4caXnRKH4x1uX0C56N475b/SoW6FttSOlFIfCsoDVM8OYSdXZwi
         C95I4oIvw9tsDW37IdU2QN3LdL/gbo6N2Ic1ZFmT13lTh2Sl5EQ4CfuZBgh4q/LVNJvN
         lbFQ==
X-Gm-Message-State: AD7BkJIBIWjpK3Kr+254oD/vphWJzQFnJ8lYyi6+VBvL2xYOtIjPcnBuYPSU2xkUzMWDofTL20VMBTw3fjhd50pb
X-Received: by 10.50.23.43 with SMTP id j11mr26091404igf.94.1458239859581;
 Thu, 17 Mar 2016 11:37:39 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Thu, 17 Mar 2016 11:37:39 -0700 (PDT)
In-Reply-To: <20160317111136.GA21745@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289139>

On Thu, Mar 17, 2016 at 4:11 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Good? Bad? Ugly?

For now I would just go with 3 directories:

non-git/ (or util, helpers, or anything that could be ripped out and be useful
    e.g. strbufs, argv-array run-command, lockfile
git/ (maybe called lib? All stuff that is pure Git and is used for libgit

builtin/ (as we have it today + all that stuff that doesn't go into
git/ very well?)

Thanks,
Stefan
