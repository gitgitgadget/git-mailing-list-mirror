Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2472614
	for <git@vger.kernel.org>; Thu, 15 May 2025 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327337; cv=none; b=pJiKyokOa9dTrlXz7541gosSjGreR4JezL44mvaJYcBENjE3Ul0DZTFAHs4ricEtHfLipRAkPMSWhiL+6wj7vhCgJEfYseOsJjrCpzMgRuVHIkmDhc023YAMo+1BIPpFNNvnQujpAFdkUEZQ3oTH4nOOuGb6Y/zLd2vB15B+mE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327337; c=relaxed/simple;
	bh=pH+ojN8gcOS5zEfdw+yaOLvwvsRUKLfmXpYvcC5YTv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJjko9uKJobMfTsTfFvLurJ2PIPzvRj8qunjMFtjD2NmatkS6GP/XRNmkTtLES6iammI+dImOKVsxDkbXZeXRxoMvfCFba7mC0vW2Aw5W4M8Ch+bMsG1jkHjHt+6H8NLkqgKF3gC9t6YSdD32YwKEMuWqGgEx/kU3zvmm5JS3ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=T5CGL5N5; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="T5CGL5N5"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id FbeiuIwi5rWcqFbejuwX56; Thu, 15 May 2025 17:42:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747327324; bh=C/ORhawS+hoopJsQYScVGJuP6bjXbssnZscjDLcfFHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=T5CGL5N5ormRB8XtnGor5uBn4YmPakdD0J/9T5ugmpAnsROdTpn9o5NKd5p6/KEQ2
	 4OzAJr3uGxhkMvxWynZKQK/ByFOBAciBypIsrJgdbIuPKFVs70TyJP++phMMMWS9qN
	 OnTl7wJ/typbqyHWO17BRAhUo05IQbMqurDOAlkCYfmEKqowELneUXY+KvcbAOKLXZ
	 W4dZAPH/Q5gR7PGTjEWw42zgPHzKVk9RxN8BQ7jqz4faH7j3JePRT0nyp+CTIH7/Hw
	 Cf69+6ge6SnbMCDDJaByWcqg9OYDbiyrxkGBhRZiEgPt0OiRGwQlU6Qpzyo1gRnce6
	 c2sxDmSMQhNPg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=OonsyD/t c=1 sm=1 tr=0 ts=6826195c
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=lgmUtR0casi4TW9MX6oA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <a163d515-2e71-4a42-b843-26d5d2ccdc59@ramsayjones.plus.com>
Date: Thu, 15 May 2025 17:42:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] meson: correct path to system config/attribute
 files
To: Patrick Steinhardt <ps@pks.im>
Cc: 'GIT Mailing-list ' <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>, Eli Schwartz <eschwartz@gentoo.org>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-4-ramsay@ramsayjones.plus.com>
 <aCQdznsNfaIeSPDI@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <aCQdznsNfaIeSPDI@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMyIltLJznhL82YY6jNSuuYzoQM+ZaPxYR6McDjg7UPvsbP8OFZnh1gTeXOXbl5Yp2/b0Ry63bEm9yydFJPRdik57zqSaniQaisVf19LOlblnVzgLWRN
 7Jb0eWcpzEFC/MwCmTLcTkkEVSGKFBilzD/3C+vQKJSbtY+sILRpn173u/oMgnGjgtPYFDN7Kub/SNUXaXD6c9Wl1NcO0AshETw=



On 14/05/2025 05:36, Patrick Steinhardt wrote:
> On Tue, May 13, 2025 at 08:17:24PM +0100, Ramsay Jones wrote:
>> diff --git a/meson.build b/meson.build
>> index 48f31157a0..7f811030bd 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -769,6 +767,20 @@ libgit_c_args = [
>>    '-DSHELL_PATH="' + fs.as_posix(target_shell.full_path()) + '"',
>>  ]
>>  
>> +system_attributes = get_option('gitattributes')
>> +if system_attributes != ''
>> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
>> +else
>> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') + '/gitattributes"'
>> +endif
>> +
>> +system_config = get_option('gitconfig')
>> +if system_config != ''
>> +  libgit_c_args += '-DETC_GITCONFIG="' + system_config + '"'
>> +else
>> +  libgit_c_args += '-DETC_GITCONFIG="' + get_option('sysconfdir') + '/gitconfig"'
>> +endif
> 
> Nit: I still think that we should use `get_option('sysconfdir') /
> 'gitattributes'`, with the slash instead of a plus, mostly because it is
> more idiomatic and reads better. But that alone doesn't warrant a
> reroll.

OK, if I need to re-roll, I will fix this up. (but see below)

>>  editor_opt = get_option('default_editor')
>>  if editor_opt != '' and editor_opt != 'vi'
>>    libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 8547c0eb47..ff877e67ce 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -3,9 +3,9 @@ option('default_pager', type: 'string', value: 'less',
>>    description: 'Fall-back pager.')
>>  option('default_editor', type: 'string', value: 'vi',
>>    description: 'Fall-back editor.')
>> -option('gitconfig', type: 'string', value: '/etc/gitconfig',
>> +option('gitconfig', type: 'string', # default 'etc/gitconfig'
>>    description: 'Path to the global git configuration file.')
>> -option('gitattributes', type: 'string', value: '/etc/gitattributes',
>> +option('gitattributes', type: 'string', # default 'etc/gitattributes'
>>    description: 'Path to the global git attributes file.')
> 
> I'd prefer if we documented the default value in the description.
> Otherwise it is impossible to discover it without having a look at the
> sources.

Hmm, but how do you get the description! :)


I applied the following patch on top:

  diff --git a/meson.build b/meson.build
  index 28276e5305..bd14bc15a1 100644
  --- a/meson.build
  +++ b/meson.build
  @@ -771,14 +771,14 @@ system_attributes = get_option('gitattributes')
   if system_attributes != ''
     libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
   else
  -  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') + '/gitattributes"'
  +  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') / 'gitattributes"'
   endif
   
   system_config = get_option('gitconfig')
   if system_config != ''
     libgit_c_args += '-DETC_GITCONFIG="' + system_config + '"'
   else
  -  libgit_c_args += '-DETC_GITCONFIG="' + get_option('sysconfdir') + '/gitconfig"'
  +  libgit_c_args += '-DETC_GITCONFIG="' + get_option('sysconfdir') / 'gitconfig"'
   endif
   
   editor_opt = get_option('default_editor')
  diff --git a/meson_options.txt b/meson_options.txt
  index ff877e67ce..7a4b896f7e 100644
  --- a/meson_options.txt
  +++ b/meson_options.txt
  @@ -4,9 +4,9 @@ option('default_pager', type: 'string', value: 'less',
   option('default_editor', type: 'string', value: 'vi',
     description: 'Fall-back editor.')
   option('gitconfig', type: 'string', # default 'etc/gitconfig'
  -  description: 'Path to the global git configuration file.')
  +  description: 'Path to the global git configuration file. (default: etc/gitconfig)')
   option('gitattributes', type: 'string', # default 'etc/gitattributes'
  -  description: 'Path to the global git attributes file.')
  +  description: 'Path to the global git attributes file. (default: etc/gitattributes)')
   option('pager_environment', type: 'string', value: 'LESS=FRX LV=-c',
     description: 'Environment used when spawning the pager')
   option('perl_cpan_fallback', type: 'boolean', value: true,
----

So, the addition of the '(default: <value>)' to the description field is
intended to mimic the setup help text for the built-in meson options:

  $ meson help setup
  usage: meson setup [-h] [--prefix PREFIX] [--bindir BINDIR] [--datadir DATADIR]
  
  ...
  
  options:
    -h, --help                            show this help message and exit
    --prefix PREFIX                       Installation prefix (default:
                                          /usr/local).
    --bindir BINDIR                       Executable directory (default: bin).
    --datadir DATADIR                     Data file directory (default: share).
    --includedir INCLUDEDIR               Header file directory (default:
                                          include).
    --infodir INFODIR                     Info page directory (default:
                                          share/info).
    --libdir LIBDIR                       Library directory (default:
                                          lib/x86_64-linux-gnu).
    --licensedir LICENSEDIR               Licenses directory (default: ).
    --libexecdir LIBEXECDIR               Library executable directory (default:
                                          libexec).
    --localedir LOCALEDIR                 Locale data directory (default:
                                          share/locale).
    --localstatedir LOCALSTATEDIR         Localstate data directory (default:
                                          var).
    --mandir MANDIR                       Manual page directory (default:
                                          share/man).
    --sbindir SBINDIR                     System executable directory (default:
                                          sbin).
    --sharedstatedir SHAREDSTATEDIR       Architecture-independent data directory
                                          (default: com).
    --sysconfdir SYSCONFDIR               Sysconf data directory (default: etc).
  
  ...
  
  $ 

Indeed, there appears to be no way to display the project specific options
to the user *before* configuring a build directory. 

  $ pwd
  /home/ramsay/git
  $ meson introspect --buildoptions
  Current directory is not a meson build directory.
  Please specify a valid build dir or change the working directory to it.
  $ 

Note that I don't recommend 'meson introspect --buildoptions' as a means
for the user to inspect the available options, but it does allow me to
check that the description field looks correct:

  $ meson introspect --buildoptions build | jq | grep gitconfig
      "name": "gitconfig",
      "description": "Path to the global git configuration file. (default: etc/gitconfig)"
  $ meson introspect --buildoptions build | jq | grep gitattributes
      "name": "gitattributes",
      "description": "Path to the global git attributes file. (default: etc/gitattributes)"
  $ 

The only way I have found to display the project options to the user (after
configuring the project) is using 'meson configure', thus:  
  
  $ meson configure build
  
  ...
  
    Project options    Current Value        Possible Values      Description      
    -----------------  -------------        ---------------      -----------      
  benchmark_large_repo                                           Large repository 
                                                                 to copy for the  
                                                                 performance      
                                                                 tests. Should be 
                                                                 at least the size
                                                                 of the Linux     
                                                                 repository.      

  ...

    gitattributes                                                Path to the      
                                                                 global git       
                                                                 attributes file. 
                                                                 (default: etc/git
                                                                 attributes)      
    gitconfig                                                    Path to the      
                                                                 global git       
                                                                 configuration    
                                                                 file. (default:  
                                                                 etc/gitconfig)   
  
  ...
  
  $ 

[Yes, I use 80 column terminals! :) ]

Note that this display shows the *current* value, not the default value, and
(once again) in this case there really isn't a default value! ;) (iff prefix
is exactly '/usr', then the 'default' is eg. '/etc/gitconfig').

Of course, the current value would be the default value unless you have
set the value on the command-line (of which you would presumably be aware).

[Well, it can be argued that eg. 'etc/gitconfig' is the default value for
the project option 'gitconfig', but that is just one input to determine
the actual path compiled into git (which _may_depend on the value of another
option ie. 'prefix')].

Having said that, the --sysconfdir default is shown as 'etc' (see above) and
that has (*is*) the same problem (ie it is '/etc' iff prefix is '/usr').

Also, looking through that list, other options which are similarly specified
to gitconfig/gitattributes don't have their 'default' noted in the description.
Why make an exception for these options?

Is this what you wanted to see? If so, then I can submit a v3 with the
above changes. Just let me know.

Thanks.

ATB,
Ramsay Jones


 

