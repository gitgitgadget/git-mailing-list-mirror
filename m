From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Thu, 3 Feb 2011 15:10:19 +0100
Message-ID: <AANLkTindnAFix+u3HKW0V-ArkzjyrDhpmN6gf9PSj0_G@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102020322.00171.johan@herland.net> <AANLkTinrqCaD_vg7Ah4Tjgoa-njEBEmiYt15ojtsazKw@mail.gmail.com>
 <201102031410.58623.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 15:10:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkzte-0005Jr-Nl
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 15:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171Ab1BCOKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 09:10:42 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61354 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113Ab1BCOKm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 09:10:42 -0500
Received: by qwa26 with SMTP id 26so948056qwa.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 06:10:41 -0800 (PST)
Received: by 10.224.176.67 with SMTP id bd3mr10256823qab.110.1296742241049;
 Thu, 03 Feb 2011 06:10:41 -0800 (PST)
Received: by 10.229.215.129 with HTTP; Thu, 3 Feb 2011 06:10:19 -0800 (PST)
In-Reply-To: <201102031410.58623.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165973>

> On Thursday 03 February 2011, Nguyen Thai Ngoc Duy wrote:
>> On Wed, Feb 2, 2011 at 9:21 AM, Johan Herland <johan@herland.net>
> wrote:
>> > Migration plan:
>> > ...
>> > In v1.8.0, we should default to the new default refspecs when
>> > creating new remotes. However, existing remotes (created
>> > pre-v1.8.0) must continue to work as before, so we cannot simply
>> > remove the implicit refspecs (or tag auto-following). Instead we
>> > need to make sure that the implicit refspecs is NOT applied to the
>> > new-style remotes. Identifying new-style vs. old-style remotes can
>> > be done by looking at the refspec itself (old-style:
>> > "refs/remotes/$remote/*", new-style:
>> > "refs/remotes/$remote/heads/*"), or (worst case) by introducing a
>> > config variable specifying the desired behavior (defaulting to
>> > old-style).
>>
>> I'd prefer config var (remote.*.implicitRules, maybe). We don't
>> reserve heads, tags... in remote namespace for ourselves. Some users
>> might have already have branches heads/ant, heads/bee... making new
>> style detection unreliable.

I don't quite follow the argument. For me the question is how likely
an old-time user has modified the refspec to read
"refs/remotes/$remote/heads/* (new-style). I think this is very, very
unlikely and thus the "heuristic" to detect old/new style works most
of the time and there is no need for a new config/compatibility key.

HTH,
Santi
