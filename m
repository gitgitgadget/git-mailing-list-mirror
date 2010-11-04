From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 2/2] rebase: teach --autosquash to match on sha1 in addition to message
Date: Thu, 4 Nov 2010 14:35:14 -0700
Message-ID: <F2547972-0FEF-4123-96AF-75F60967DAB5@sb.org>
References: <1288838504-69114-1-git-send-email-kevin@sb.org> <1288838504-69114-2-git-send-email-kevin@sb.org> <5CCA000B-2178-4DF7-8D72-29F95A9BB360@sb.org> <AANLkTikA_46ZdrRBCnh-1Rx1jfqGb377jeg=9OO5T3Tr@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:35:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7Ss-0007eI-6m
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab0KDVfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 17:35:17 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64199 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab0KDVfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 17:35:16 -0400
Received: by pwj7 with SMTP id 7so364103pwj.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 14:35:15 -0700 (PDT)
Received: by 10.143.41.2 with SMTP id t2mr1219395wfj.156.1288906515827;
        Thu, 04 Nov 2010 14:35:15 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id p8sm517088wff.16.2010.11.04.14.35.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 14:35:14 -0700 (PDT)
In-Reply-To: <AANLkTikA_46ZdrRBCnh-1Rx1jfqGb377jeg=9OO5T3Tr@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160774>

On Nov 4, 2010, at 3:44 AM, Sverre Rabbelier wrote:

> On Thu, Nov 4, 2010 at 05:49, Kevin Ballard <kevin@sb.org> wrote:
>> I just realized that this only works for sha1's of up to 7 characters.
>> If you provide more it won't match, as it's comparing against the sha1
>> given in the todo list. I wonder if it's worth resolving all sha1s to
>> their full length if the provided string is longer than 7 characters?
> 
> Well, not if you're resolving them based on the 7-character string
> from the rebase todo list. If you run in to ambiguity with those
> 7-length hash we should instead increase the length of the hashes in
> the todo list.
> 
> So I'd say, solve this by doing a prefix match?

Prefix match of what against what? If the 7-character string used in the
TODO list is already ambiguous, then the rebase itself would be expected
to fail. I'm inclined to just try to resolve the message in the fixup!
line itself to a full SHA1, and if that works, then try to match the
7-character sha1 with a prefix comparison.

-Kevin Ballard
