From: Mark A Rada <marada@uwaterloo.ca>
Subject: Re: [PATCHv2 2/2] gitweb: support to globally enable/disable a snapshot format
Date: Sat, 1 Aug 2009 19:50:38 -0400
Message-ID: <D33D9C93-300E-4565-8040-BED425A6F2FE@uwaterloo.ca>
References: <1CE4F545-1ACA-4786-B0F2-EE7C746E6585@uwaterloo.ca> <m3hbwrqly9.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 01:51:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXOLw-0004qL-Fc
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 01:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbZHAXuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 19:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbZHAXuu
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 19:50:50 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:65333 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751096AbZHAXut (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 19:50:49 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n71Noh5Z005372
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 1 Aug 2009 19:50:46 -0400 (EDT)
In-Reply-To: <m3hbwrqly9.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sat, 01 Aug 2009 19:50:47 -0400 (EDT)
X-Miltered: at mailchk-m04 with ID 4A74D4D3.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m03
X-Virus-Status: Clean
X-UUID: 59a7ec53-79e7-4ce7-bb26-39f3996db2da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124653>


On 1-Aug-09, at 5:11 PM, Jakub Narebski wrote:

> Mark A Rada <marada@uwaterloo.ca> writes:
>
>> ------->8-------------
>> From: Mark Rada <marada@uwaterloo.ca>
>> Date: Sat, 1 Aug 2009 13:24:03 -0400
>> Subject: [PATCH 2/2] gitweb: support to globally enable/disable a  
>> snapshot format
>>
>> I added a 'disabled' variable to to the $known_snapshot_formats  
>> keys so
>> that a Gitweb administrator can globally enable or disable a specific
>> format for snapshots.
>>
>> All formats are enabled by default because project specific  
>> overriding
>> is disabled by default.
>>
>> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
>
> O.K.  I think this patch now covers everything needed.  Well, except
> documentation.
>

Documentation documentation or code comments documentation?

>> ---
>>  gitweb/gitweb.perl |   17 ++++++++++++-----
>>  1 files changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 3398163..a59569f 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -167,27 +167,31 @@ our %known_snapshot_formats = (
>
> At the beginning of %known_snapshot_formats definition there is a
> comment with description of structure of this hash.  You should have
> updated it, for example in the following way:
>
> @@ -168,7 +168,8 @@ our %known_snapshot_formats = (
> 	# 	'suffix' => filename suffix,
> 	# 	'format' => --format for git-archive,
> 	# 	'compressor' => [compressor command and arguments]
> -	# 	                (array reference, optional)}
> +	# 	                (array reference, optional),
> +	# 	'disabled' => boolean (optional)}
> 	#
> 	'tgz' => {
> 		'display' => 'tar.gz',
>
> The above is, of course, not the only possible way.
>
>>  		'type' => 'application/x-gzip',
>>  		'suffix' => '.tar.gz',
>>  		'format' => 'tar',
>> -		'compressor' => ['gzip']},
>> +		'compressor' => ['gzip'],
>> +		'disabled' => 0},
>>
>>  	'tbz2' => {
>>  		'display' => 'tar.bz2',
>>  		'type' => 'application/x-bzip2',
>>  		'suffix' => '.tar.bz2',
>>  		'format' => 'tar',
>> -		'compressor' => ['bzip2']},
>> +		'compressor' => ['bzip2'],
>> +		'disabled' => 0},
>>
>>  	'txz' => {
>>  		'display' => 'tar.xz',
>>  		'type' => 'application/x-xz',
>>  		'suffix' => '.tar.xz',
>>  		'format' => 'tar',
>> -		'compressor' => ['xz']},
>> +		'compressor' => ['xz'],
>> +		'disabled' => 0},
>>
>>  	'zip' => {
>>  		'display' => 'zip',
>>  		'type' => 'application/x-zip',
>>  		'suffix' => '.zip',
>> -		'format' => 'zip'},
>> +		'format' => 'zip',
>> +		'disabled' => 0},
>>  );
>
> Although I though that we don't need to put "'disabled' => 0", as
> the fact that 'disabled' key does not exist means that it is enabled.
>
> But if you chose to have all known formats not disabled, then I think
> it is a correct solution.  (And then choosing between 'enabled' and
> 'disabled' is mainly a matter of taste.)
>

I think spelling it out explicitly in each case makes things more  
clear, but
would it not increase the memory footprint ever so slightly (I'm not  
familiar
with PERL internals and whether having a field in one hash entry means
it will have memory allocated in all the rest). I'm also not convinced  
that
worrying about this micro-optimization is worth it.


>>
>>  # Aliases so we understand old gitweb.snapshot values in repository
>> @@ -502,7 +506,8 @@ sub filter_snapshot_fmts {
>>  		exists $known_snapshot_format_aliases{$_} ?
>>  		       $known_snapshot_format_aliases{$_} : $_} @fmts;
>>  	@fmts = grep {
>> -		exists $known_snapshot_formats{$_} } @fmts;
>> +		exists $known_snapshot_formats{$_} &&
>> +		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
>>  }
>>
>>  our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
>> @@ -5171,6 +5176,8 @@ sub git_snapshot {
>>  		die_error(400, "Unknown snapshot format");
>>  	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
>>  		die_error(403, "Unsupported snapshot format");
>> +	} elsif ($known_snapshot_formats{$format}{'disabled'}) {
>> +		die_error(403, "Snapshot format not allowed");
>>  	}
>>
>>  	if (!defined $hash) {
>
> Now I think that covers everything: preventing displaying known but
> disabled snapshot formats in snapshots links in gitweb, and preventing
> using known but disabled snapshot format.
>
> -- 
> Jakub Narebski
>
> Git User's Survey 2009
> http://tinyurl.com/GitSurvey2009

--
Mark A Rada (ferrous26)
marada@uwaterloo.ca
