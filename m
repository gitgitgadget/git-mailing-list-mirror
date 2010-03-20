From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [gitk PATCH] gitk: Disable log.decorate config
Date: Sat, 20 Mar 2010 12:39:32 +0100
Message-ID: <adf1fd3d1003200439o52d45632v7096b6bef64f744b@mail.gmail.com>
References: <1269038663-11025-1-git-send-email-santi@agolina.net>
	 <20100320051055.GA3855@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Mar 20 12:39:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsx1p-0004Tl-IT
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 12:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab0CTLjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 07:39:35 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:55688 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab0CTLje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 07:39:34 -0400
Received: by fxm19 with SMTP id 19so1290607fxm.21
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 04:39:32 -0700 (PDT)
Received: by 10.103.4.14 with SMTP id g14mr10873939mui.84.1269085172329; Sat, 
	20 Mar 2010 04:39:32 -0700 (PDT)
In-Reply-To: <20100320051055.GA3855@brick.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142704>

On Sat, Mar 20, 2010 at 6:10 AM, Paul Mackerras <paulus@samba.org> wrot=
e:
> On Fri, Mar 19, 2010 at 11:44:23PM +0100, Santi B=E9jar wrote:
>
>> Since eb73445 (Add `log.decorate' configuration variable., 2010-02-1=
7)
>> the log output changes if log.decorate is set. Gitk is unable to
>> understand the new output (it returns the error: "Can't parse git lo=
g
>> output: {commit $sha1 $sha2...}), so disable it with --no-decorate.
>>
>> Signed-off-by: Santi B=E9jar <santi@agolina.net>
>> ---
>> =A0gitk | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/gitk b/gitk
>> index 1f36a3e..aca44b7 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -362,7 +362,7 @@ proc start_rev_list {view} {
>>
>> =A0 =A0 =A0if {[catch {
>> =A0 =A0 =A0 set fd [open [concat | git log --no-color -z --pretty=3D=
raw --parents \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--boundary $args "--" $=
files] r]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--boundary --no-decorat=
e $args "--" $files] r]
>
> We'll need to make that conditional on the git version, since we want
> gitk to continue to work on older git installations.

I see. I didn't find a version check for the --no-color (I know it is
much older, but still), so I did the same.

But as Jeff said it will be solved within git itself.

Santi
