From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 3/6] gitweb: rss feed managingEditor
Date: Fri, 6 Feb 2009 12:03:26 +0100
Message-ID: <cb7bb73a0902060303s35527b3ey8572d60c54066e33@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232970616-21167-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232970616-21167-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902050019.44016.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 12:05:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOW1-0001ZF-3D
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZBFLDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbZBFLD3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:03:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:25068 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbZBFLD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:03:28 -0500
Received: by nf-out-0910.google.com with SMTP id d3so126845nfc.21
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 03:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y9QmowO/nTt3qS+zL2oaDvsLauTHPuiZ/St9Y3vkPv4=;
        b=RmYhj+KHDJ7zT4UPWFjrCf6zRItpAcJJRcSWKLGYGMGxKIDRJxcl3J9S+ODsGgqPKV
         mOpCk+nHUmDpFYqS/NdIghbytRnS6K//tw6yP98v3U30ohpPAMTkpCdNqGcs2pPVVPPB
         b0dPpBm9aMSP1LPoWk+lk6qBWIzmsjNvM7y3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iN+7Gf5yVeGJPp3DtETySuHI6orbDd8Tu8SXLOThTrWcYE9OD6MBAk+QcEnCxwAU1d
         0EN7fNbmvm+aaFxGUQDrFRFh35WGb/lCqAEi2X/fQ384yarattM+uvn6b+FSfU6DR/MI
         tIK5y8a/EoEuBbjqCGcUMi1YTs7HR+axWIRiE=
Received: by 10.210.62.3 with SMTP id k3mr1204621eba.182.1233918207012; Fri, 
	06 Feb 2009 03:03:27 -0800 (PST)
In-Reply-To: <200902050019.44016.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108681>

On Thu, Feb 5, 2009 at 12:19 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:
>
>> The RSS 2.0 specification allows an optional managingEditor tag for the
>> channel, containing the "email address for person responsible for editorial
>> content", which is basically the project owner.
>
> Hmmm... does it make sense with gitweb? Perhaps it does...

I must confess I had my own doubts about this 8-D

>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>>  gitweb/gitweb.perl |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 3d94f50..cc6d0fb 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -6074,7 +6074,9 @@ XML
>>               print "<title>$title</title>\n" .
>>                     "<link>$alt_url</link>\n" .
>>                     "<description>$descr</description>\n" .
>> -                   "<language>en</language>\n";
>> +                   "<language>en</language>\n" .
>> +                   # project owner is responsible for 'editorial' content
>> +                   "<managingEditor>$owner</managingEditor>\n";
>
> Shouldn't we esc_html($owner), just in case it is for example
> "O Wner <owner@example.com>" (either via gitweb.owner or via
> projects_index being text file listing projects, because I don't
> see GECOS having email in it...)?
>

Indeed, itt's probably safer to do the escaping.


-- 
Giuseppe "Oblomov" Bilotta
