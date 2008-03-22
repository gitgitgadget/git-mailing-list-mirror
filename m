From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: Recording cherry-picked commits
Date: Sat, 22 Mar 2008 23:48:32 +0100
Message-ID: <b77c1dce0803221548x3250cb90taa9a9d53464f7ea7@mail.gmail.com>
References: <ae63f8b50803210533n12645fb3w9a8be601c4cc394@mail.gmail.com>
	 <ae63f8b50803220937k78571fbdl1eeb60966ec7aa40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jean-Baptiste Quenot" <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 23:49:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdCWZ-000450-Jj
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 23:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464AbYCVWsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 18:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754471AbYCVWsd
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 18:48:33 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:47832 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbYCVWsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 18:48:32 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2272014wff.4
        for <git@vger.kernel.org>; Sat, 22 Mar 2008 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zttSYkOb7cVgbNMmQgBQLkklpu/4k4KZFHH4G8rvGgM=;
        b=S/8qsllfmNLkG8BmGn4Biknudt81BNiVFaL8uqs7UwMeJq0P3YeVLla368n/DlcmNPgxlzD+Xuyj5RUKHCe6lvJqbuZ1XVGtYy6LV/DnKI5FFmljbRTxa9TEukfFEPJ4zB42MhNDILye99LND2fUk7xKQXNWBltYAB2wYV2eOzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K8124L5vqlIlYSoD4zJpglcVJvGbNRcHHyQ3kTCAQGYBH9qsSZK9AwfnNvN0My7Vnptf18SW9vp8zLBTNNSCPBHVBipcIXMkPEt19TatEa082lNRn/RGVZuupRjYuNxAdnPyZ6GZHMtSHdeihcZDYKzPUGK1bLjL1mWqNxA4A8k=
Received: by 10.142.52.9 with SMTP id z9mr3379506wfz.134.1206226112326;
        Sat, 22 Mar 2008 15:48:32 -0700 (PDT)
Received: by 10.142.156.10 with HTTP; Sat, 22 Mar 2008 15:48:32 -0700 (PDT)
In-Reply-To: <ae63f8b50803220937k78571fbdl1eeb60966ec7aa40@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77858>

On 22/03/2008, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
> What about using a hidden ".gitcherry" file in the current branch to
>  store the commits that have been applied?  With the simple shell
>  scripts below I'm able to achieve the same effect as svnmerge:

(.gitcherry should really be at the root of the git repository, not in
the current directory)

What happens to .gitcherry across merges ? I think your solution isn't
robust enough.

Here's an alternate idea: store the original sha1 in the commit
message, via a custom header (something like X-Cherry-Picked-From) at
least in case of conflict, and have git-cherry recognize it.

(I have the same problem as you, by the way, and would really like to
see it solved one way or another.)
