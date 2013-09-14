From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH V2 1/3] Doc URLs: relative paths imply the dot-respository
Date: Sat, 14 Sep 2013 21:47:14 +0100
Organization: OPDS
Message-ID: <1ADD7BEB330F4246983C461C9B1018FF@PhilipOakley>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org><1379107397-964-1-git-send-email-philipoakley@iee.org><1379107397-964-2-git-send-email-philipoakley@iee.org> <xmqq7gekicqq.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Felipe Contreras" <felipe.contreras@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 22:47:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKwkR-00032H-MH
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 22:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690Ab3INUrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 16:47:15 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:44150 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753374Ab3INUrO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Sep 2013 16:47:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArMGAGTKNFJOl3GZ/2dsb2JhbABagweJcrgMCoEcF3SCIAUBAQQBCAEBLh4BASEFBgIDBQIBAxUBCyUUAQQaBgcXBhMIAgECAwGHbAq5YI9zgyWBAAOJAIYSml2DJTs
X-IPAS-Result: ArMGAGTKNFJOl3GZ/2dsb2JhbABagweJcrgMCoEcF3SCIAUBAQQBCAEBLh4BASEFBgIDBQIBAxUBCyUUAQQaBgcXBhMIAgECAwGHbAq5YI9zgyWBAAOJAIYSml2DJTs
X-IronPort-AV: E=Sophos;i="4.90,904,1371078000"; 
   d="scan'208";a="441209359"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip02ir2.opaltelecom.net with SMTP; 14 Sep 2013 21:47:12 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234807>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, September 13, 2013 11:21 PM
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  Documentation/urls.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
>> index 9ccb246..5350a63 100644
>> --- a/Documentation/urls.txt
>> +++ b/Documentation/urls.txt
>> @@ -55,6 +55,13 @@ These two syntaxes are mostly equivalent, except 
>> the former implies
>>  --local option.
>>  endif::git-clone[]
>>
>> +Relative paths are relative to the `$GIT_DIR`, thus the path:
>
> Is it?
>
> git init src dst

I didn't think you could do that. It's not documented (initialise 
multiple dirctories with the same command) and on msysgit if fails with 
`usage:`. But I know what you mean.

>        cd src
>        git commit --allow-empty -m initial
>        cd ../dst
>        git fetch ../src HEAD:refs/heads/copy
>
> would work, but if it is relative to $GIT_DIR, the last one would
> need to be written as
>
> git fetch ../../src HEAD:refs/heads/copy
>
> wouldn't it?

Ah but... we are specifying a repository here, not a file path, so the 
`$GIT_DIR` / '.git'  discovery comes into it, I think. It's the 
discovery of the relevant  repository that I now realise I've not 
included, which can be confusing in the various special cases. So the 
relative paths comment will be incomplete [your point], and needs 
something extra between "relative to" and "the $GIT_DIR".

>
>> +
>> +- '.'
>> +
>> +is the current repository and acts as if it were a repository
>> +named `'.'`.
>> +
>>  When Git doesn't know how to handle a certain transport protocol, it
>>  attempts to use the 'remote-<transport>' remote helper, if one
>>  exists. To explicitly request a remote helper, the following syntax
