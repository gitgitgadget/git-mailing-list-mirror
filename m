From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] clean cached refs when calling set_git_dir()
Date: Thu, 10 Mar 2011 22:59:16 +0700
Message-ID: <AANLkTik1HMQqKc98AF-6DTGJgrk8HOjZTimGnK-XBv-q@mail.gmail.com>
References: <1299770345-32055-1-git-send-email-plenz@cis.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Julius Plenz <plenz@cis.fu-berlin.de>
X-From: git-owner@vger.kernel.org Thu Mar 10 17:00:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxiHd-0005SB-Ap
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 17:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab1CJP7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 10:59:53 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57348 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab1CJP7r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 10:59:47 -0500
Received: by wwa36 with SMTP id 36so2111116wwa.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ZS9dl/IURZrz/IMoi4ITj3UoCIiRrErJkVtHj0sRQys=;
        b=XTAexSi+UKxfyWnI8PcPUFtcGzxiP7UZA9jYeQDjLI76add/NPcWq4q/9l3N8eAW3v
         hv6ZyQ+3plFwmvNZMLUiS7VXOfyXA+XCLFjy7XDgNyajsfhBKtxqMQlhVnKJv8MfgfXH
         fG4EQnFEIhc3as5YokoeCeuPKYGVwP6A27g2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=x60Vj5OzwRq1vaMaE9oUZrctarMKW9PQZBC7cbXU55kmp2tjJWtA9sjiIxYEJTsIU1
         83OS15UoyqGOHWw23YftkPqwMicr0aDE0yjlkAf4J7gFpoiDF4lkB1XT3QvMD8ffkZmo
         0SSBT+TeTAeDnhGtKCapYjvK/3N1vurT3zb7M=
Received: by 10.216.87.8 with SMTP id x8mr7175587wee.46.1299772786130; Thu, 10
 Mar 2011 07:59:46 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Thu, 10 Mar 2011 07:59:16 -0800 (PST)
In-Reply-To: <1299770345-32055-1-git-send-email-plenz@cis.fu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168828>

On Thu, Mar 10, 2011 at 10:19 PM, Julius Plenz <plenz@cis.fu-berlin.de> wrote:
> If you use libgit.a to perform reference resolutions on two or more
> repositories that contain packed refs, cached_refs will store the packed
> refs for the first repository to contain a packed-refs file only.

If you use libgit.a to do anything on more than one repository, you
get a lot more messed up that just that. Spawning a new process or
accessing with libgit2 may be safer. Why do you want to do that in the
first place?
-- 
Duy
