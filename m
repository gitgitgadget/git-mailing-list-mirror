Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0391C20248
	for <e@80x24.org>; Mon, 11 Mar 2019 14:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCKOP4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 10:15:56 -0400
Received: from mail-eopbgr810101.outbound.protection.outlook.com ([40.107.81.101]:8704
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727219AbfCKOP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 10:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ontextron.onmicrosoft.com; s=selector1-trusimulation-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzKXscwBu82nuMyHIePte787Z0nmcHvZxgEeHg/bWpE=;
 b=yKG/bTFWy1aBU+8FPBZ6dK5+KOZmljJcLTzEMQ4GG9cU9hnRKnRAl3fDI8fQMf7Ze+mU26cetQpwlaHclCSqtPAocv17l6ejOXXtbO3AZRqG/S5JvQei2ERzu8Ur4yCePDHGg0uequMjvlaRrGRfeWYNK0G9meVrLhoFuXBoE1E=
Received: from SN6PR03MB3647.namprd03.prod.outlook.com (52.135.80.148) by
 SN6PR03MB3565.namprd03.prod.outlook.com (52.135.80.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 14:15:33 +0000
Received: from SN6PR03MB3647.namprd03.prod.outlook.com
 ([fe80::151b:3a78:63f:8308]) by SN6PR03MB3647.namprd03.prod.outlook.com
 ([fe80::151b:3a78:63f:8308%4]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 14:15:33 +0000
From:   "Garcia, Pierre" <pgarcia@trusimulation.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Bug: git for Windows spawning a lot of processes recursively
Thread-Topic: Bug: git for Windows spawning a lot of processes recursively
Thread-Index: AdTKX37R6NVOZpIeSUOzs9W/WhkzYALkcTcAAIgDrqA=
Date:   Mon, 11 Mar 2019 14:15:32 +0000
Message-ID: <SN6PR03MB364776AC6AB063BFEA7F3310BA480@SN6PR03MB3647.namprd03.prod.outlook.com>
References: <SN6PR03MB3647F1CDFD95F29C86F54FF8BA7F0@SN6PR03MB3647.namprd03.prod.outlook.com>
 <nycvar.QRO.7.76.6.1903082154320.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1903082154320.41@tvgsbejvaqbjf.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgarcia@trusimulation.com; 
x-originating-ip: [32.66.32.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71aac6a3-fbae-4810-f3a5-08d6a62c062a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB3565;
x-ms-traffictypediagnostic: SN6PR03MB3565:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR03MB3565;23:SPEqRJiyTPUKqN7qHOV8zdcBrhhWaNr7BAYQmGmQL?=
 =?us-ascii?Q?JQeDmhEgHsP1vYwfXzuXbZz3Y+AiHnSN+TXLuM/ylvJ1UwwOhpBZnIGjfK/M?=
 =?us-ascii?Q?N1h6Vs18wRLq6Q048R5flWDxZ3vyVw3F4mtt/bpWZnTYuthpWJi5jVq2wy01?=
 =?us-ascii?Q?0ZHBCNAnt8nQPFJaD64fkWTlMWg2gXry045SHa0CXc3h9gYpsqpJq3TVB7nX?=
 =?us-ascii?Q?OffrTdCbKMjaDtJ2cK43xwCfnF95+4LRhcBWGm7rpwmOK+7/MTAs08SzIsis?=
 =?us-ascii?Q?2nSbpgVbDTx7GX2ZDqutkGa/tZJGCkXa0E+Z9TFhw4AWrybNTdS1jisYaXco?=
 =?us-ascii?Q?8kS/PTOGlfMfl+zc5y02vrsJxU1BLh+BXT2EZzHZNqX/JZPbWoLNAC4tEo8l?=
 =?us-ascii?Q?raietNLMP4s7is1AXRlN/KRfS3nxYUmZzE6743WNd8EEBKwcxh1FAgaG67SS?=
 =?us-ascii?Q?wtewGPJKsIcyT0LN+iPQyO+pu7Ks7aGbROiGgJg5VBUPhU5WCRAnDkYD/7at?=
 =?us-ascii?Q?FJq29/PLSiLtwJVNT3TSCy3ChSS6CcGYxHd2ESE8oy/ujrl79IPzWUgoIhPX?=
 =?us-ascii?Q?mjbhT94Deu9RG1TSNmAZkAIRJkhQ+xnn6kwwRbNQTnIh4Xi7q1T4d7VGrnSF?=
 =?us-ascii?Q?oS+aXlRwHCcCNoeRYgEn/aEFnHUPc1kJI32qBsDDKoKXMOLYXrNlTcWre9Z2?=
 =?us-ascii?Q?DCUPqsugAtjmamFaOXCDwiA5QOu/W/tUPxbZrvi8KuEFvjoLv6xKIHqS3aBd?=
 =?us-ascii?Q?LCirccpBKuLxV+iBbLhMnEOBtQNzRgIXwCIS+N7UDA1AyAE0ox4xTuKdB6pb?=
 =?us-ascii?Q?dcuyg1y9PnfZNK+bofzM5k4uwm02BMYZXVVodhI1/PAOTETr4aPqqTLACw7e?=
 =?us-ascii?Q?L6QC0MZiw3lv15ZlDSh3F3JoP4N5+l9bUf8bpfrcTcrIyhoHGahD0sJTNjy1?=
 =?us-ascii?Q?QgW7t8SoHCpyITB7Aw81DvAKYkA3IH/f1VE8W2gdGe8pU0j5R1/lej+KqB/h?=
 =?us-ascii?Q?mTzoHGhBIGcoBVtPm81NZsmHJScWjVl4VmDLUyNcUiQ8TYyKQZO2jAWIEx6f?=
 =?us-ascii?Q?3HfiLePKZF9vQB6yNTCwm/uJ6NOxDiRChNZnB31ipkS+y0jgW8kIN5NUAlza?=
 =?us-ascii?Q?TfV4oDDG9aFEPa89ER7aMTG164/5R9+a/Zrc7Qi2h5f7krhnw3IeCBSEIexC?=
 =?us-ascii?Q?YJsNjFhTE2we8U0bAvqqg7Drws9dCd+V3fM3jee2NP1i/tXOkqd75R/j0NsO?=
 =?us-ascii?Q?kT3uJC4egk+8/715A7U8Z6tfqY/71XqlumnXYJLOzuVcW4Rg8Gf4elDDLu2X?=
 =?us-ascii?Q?Lb48k13ral3pNQJeowJ5UkF/MqQXcywBzPWSYRW/USDgvS2HIVBiCVNErGm0?=
 =?us-ascii?Q?FbUDNelZCKApHaI6SxfRMH+TuydcMj7m5jN+AdZ4sM0sWz5eI8YagqKXWc4b?=
 =?us-ascii?Q?j7vGjZ+fQ=3D=3D?=
x-microsoft-antispam-prvs: <SN6PR03MB3565767B48714AB0828D1B46BA480@SN6PR03MB3565.namprd03.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(136003)(366004)(346002)(189003)(199004)(13464003)(966005)(81166006)(53936002)(8676002)(347745004)(6246003)(106356001)(30864003)(105586002)(6436002)(26005)(14444005)(53946003)(186003)(6306002)(4326008)(55016002)(316002)(478600001)(256004)(9686003)(14454004)(68736007)(45080400002)(81156014)(97736004)(25786009)(71190400001)(71200400001)(8936002)(2906002)(6116002)(3846002)(446003)(7736002)(52536013)(33656002)(74316002)(305945005)(6916009)(486006)(76176011)(6506007)(229853002)(7696005)(99286004)(66066001)(53546011)(5660300002)(86362001)(11346002)(476003)(102836004)(579004)(460985005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR03MB3565;H:SN6PR03MB3647.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: trusimulation.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BacGpppc5W9ol6tVQppF9b+9HLHoTAKlsZnNVZhe75xDKE8DmixzBK2AC6prIiK1LPLBvILEPGwMMkgESbjmu/6EY6JkjeuRVS28qjm+PCv+xM9tM0sEMF6E+j547MbnvLWpUexRnz6w9SVNapMDFd2yGZB+2wkdVHCOxxlH2ZdF+bW/J1leR3eZ/yIPl2IaoDfRNpSrmLZ4W1Z8jNiAtLRUjTutqUaQ3VApLZ/lDKfY8jg8XQDPwwDZGJLSMdP0sPCs8NIY0dKRpGvp5NtP6lpkBb/coGLy4gFbtxr0f2zm5NK6nFuqptHRfdyJXlPZJJ2/CAiUO9dBIAd5KOu4XfH8CTTYQ8YnvoLLcE0HXb1wpKd0CK1uC0nAuAUw6YOKPtdoBYG5AjIHBFdv0EYoA8RVLYT3n2qZadOF8ve4vf4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: trusimulation.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aac6a3-fbae-4810-f3a5-08d6a62c062a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 14:15:32.8451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d5b202c-8c07-4168-a551-66f570d429b3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3565
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

I installed the following snapshot on the problematic machine:
Sun, 10 Mar 2019 17:37:25 +0100
(commit eb5d06f545)
Git for Windows installer: 64-bit

And the problem is gone! No more issue!

At the time I had the issue I was on field trip with limited time and no ot=
her version to try at hand - as a workaround I ended up having GitExtension=
 point to the mingw64 binary and it worked normally.
I tried the exact same version that caused the problem on the laptop, on an=
other machine and I didn't get the issue this time, so the problem might be=
 tied to a very specific setup.

Cheers,
Pierre

-----Original Message-----
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=20
Sent: Friday, March 08, 2019 15:56
To: Garcia, Pierre <pgarcia@trusimulation.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: git for Windows spawning a lot of processes recursively

Hi Pierre,

On Fri, 22 Feb 2019, Garcia, Pierre wrote:

> I'd like to report an issue with git for Windows
>=20
> Git version 2.20.1
> Windows 7 x64 (Build 7601: Service Pack 1)
>=20
> ----------------------------------------------------------------------
> ------
> Issue:
> When running from Git-bash (not even inside a repo), git commands from=20
> built-in are OK, but if I use the exe that is located at C:\Program=20
> Files\Git\bin\git.exe, the process takes long to execute and then=20
> exits with error "error launching git: The filename or extension is=20
> too
> long.":

Is this still happening with v2.21.0? Or for that matter, with the latest s=
napshot at https://wingit.blob.core.windows.net/files/index.html?

Ciao,
Johannes

>=20
> $ git --version
> git version 2.20.1.windows.1
>=20
> $ which git
> /mingw64/bin/git
>=20
> $ /c/Program\ Files/Git/bin/git.exe --version error launching git: The=20
> filename or extension is too long.
>=20
> ----------------------------------------------------------------------
> ------ It started out of the blue, nothing special was done on the=20
> computer, the previous day I cloned some repos, the next it was not worki=
ng anymore.
> I tried uninstall-reinstall with no success.
> I'm using Gitextensions as well, but I verified that the problem was occu=
rring without Gitextensions (uninstalled at the time the traces were taken)=
.
>=20
> ----------------------------------------------------------------------
> ------ I ran procmon.exe to monitor the activity of the process and I=20
> found out that git.exe was spawning itself 385 times in total in the trac=
e I took, until all processes exit with error code 1, here is an extract of=
 the procmon trace, showing thread and process activity for git.exe (I have=
 more exhaustive trace but the file is quite big), I included the environme=
nt variables on the first call:
>=20
> Time of Day	Process Name	PID	Operation	Path	Result	Detail
> 8:57:20.7	git.exe	12744	Process Start		SUCCESS	"Parent PID: 8412, Command=
 line: ""C:\Program Files\Git\bin\git.exe""  --version, Current directory: =
C:\Users\gpierre\Desktop\, Environment:=20
> ;	=3D::=3D::\
> ;	=3DC:=3DC:\Users\gpierre\Desktop
> ;	=3DExitCode=3D00000001
> ;	ALLUSERSPROFILE=3DC:\ProgramData
> ;	CommonProgramFiles=3DC:\Program Files\Common Files
> ;	CommonProgramFiles(x86)=3DC:\Program Files (x86)\Common Files
> ;	CommonProgramW6432=3DC:\Program Files\Common Files
> ;	ComSpec=3DC:\windows\system32\cmd.exe
> ;	DEFLOGDIR=3DC:\ProgramData\McAfee\Endpoint Security\Logs
> ;	FP_NO_HOST_CHECK=3DNO
> ;	GTK_BASEPATH=3DC:\Program Files (x86)\GtkSharp\2.12\
> ;	HasSCCM2012Client=3D1
> ;	HOME=3DC:\Users\gpierre
> ;	HOMEDRIVE=3DC:
> ;	HOMEPATH=3D\Users\gpierre
> ;	HOMESHARE=3DC:\Users\gpierre
> ;	LOCALAPPDATA=3DC:\Users\gpierre\AppData\Local
> ;	NUMBER_OF_PROCESSORS=3D4
> ;	OS=3DWindows_NT
> ;	Path=3DC:\ProgramData\Oracle\Java\javapath;C:\windows\system32;C:\windo=
ws;C:\windows\System32\Wbem;C:\windows\System32\WindowsPowerShell\v1.0\;C:\=
Program Files\Dell\Dell Data Protection\Encryption\;C:\Program Files (x86)\=
NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft SQL Server\130\T=
ools\Binn\;C:\Program Files\dotnet\;C:\Program Files (x86)\GtkSharp\2.12\bi=
n;C:\windows\system32\config\systemprofile\.dnx\bin;C:\Program Files\Micros=
oft DNX\Dnvm\;C:\EASE\APEX12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\defau=
lt\DEOS;C:\Program Files\PuTTY\;C:\windows\System32\WindowsPowerShell\v1.0\=
;C:\windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\1E\NomadBranc=
h\;C:\HashiCorp\Vagrant\bin;C:\windows\System32\WindowsPowerShell\v1.0\
> ;	PATHEXT=3D.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
> ;	PROCESSOR_ARCHITECTURE=3DAMD64
> ;	PROCESSOR_IDENTIFIER=3DIntel64 Family 6 Model 94 Stepping 3, GenuineInt=
el
> ;	PROCESSOR_LEVEL=3D6
> ;	PROCESSOR_REVISION=3D5e03
> ;	ProgramData=3DC:\ProgramData
> ;	ProgramFiles=3DC:\Program Files
> ;	ProgramFiles(x86)=3DC:\Program Files (x86)
> ;	ProgramW6432=3DC:\Program Files
> ;	PROMPT=3D$P$G
> ;	PSModulePath=3DC:\Program Files\WindowsPowerShell\Modules;C:\windows\sy=
stem32\WindowsPowerShell\v1.0\Modules
> ;	PUBLIC=3DC:\Users\Public
> ;	SESSIONNAME=3DConsole
> ;	SNC_LIB=3Dgsskrb5.dll
> ;	SOEDataPartition=3DC:
> ;	SOEDesktopAdminModel=3DUser
> ;	SOESystemPartitionLabel=3DSOE-Disk
> ;	SystemDrive=3DC:
> ;	SystemRoot=3DC:\windows
> ;	TEMP=3DC:\Users\gpierre\AppData\Local\Temp
> ;	TMP=3DC:\Users\gpierre\AppData\Local\Temp
> ;	USERNAME=3Dgpierre
> ;	USERPROFILE=3DC:\Users\gpierre
> ;	VBOX_MSI_INSTALL_PATH=3DC:\Program Files\Oracle\VirtualBox\
> ;	VS140COMNTOOLS=3DC:\Program Files (x86)\Microsoft Visual Studio 14.0\Co=
mmon7\Tools\
> ;	VS80COMNTOOLS=3DC:\Program Files (x86)\Microsoft Visual Studio 8\Common=
7\Tools\
> ;	windir=3DC:\windows
> ;	windows_tracing_flags=3D3
> ;	windows_tracing_logfile=3DC:\BVTBin\Tests\installpackage\csilogfile.log=
"
> 8:57:20.7	git.exe	12744	Thread Create		SUCCESS	Thread ID: 12748
> 8:57:20.7	git.exe	12744	Load Image	C:\Program Files\Git\bin\git.exe	SUCCE=
SS	Image Base: 0x13a0000, Image Size: 0x52000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\ntdll.dll	SUCCESS	=
Image Base: 0x77b70000, Image Size: 0x19f000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\kernel32.dll	SUCCE=
SS	Image Base: 0x77950000, Image Size: 0x11f000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\KernelBase.dll	SUC=
CESS	Image Base: 0x7fefd860000, Image Size: 0x6a000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\msvcrt.dll	SUCCESS=
	Image Base: 0x7fefef60000, Image Size: 0x9f000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\shell32.dll	SUCCES=
S	Image Base: 0x7fefdc20000, Image Size: 0xd8a000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\shlwapi.dll	SUCCES=
S	Image Base: 0x7feffde0000, Image Size: 0x71000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\gdi32.dll	SUCCESS	=
Image Base: 0x7fefdae0000, Image Size: 0x67000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\user32.dll	SUCCESS=
	Image Base: 0x77a70000, Image Size: 0xfa000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	Im=
age Base: 0x7fefed30000, Image Size: 0xe000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\usp10.dll	SUCCESS	=
Image Base: 0x7fefdb50000, Image Size: 0xcb000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\imm32.dll	SUCCESS	=
Image Base: 0x7fefe9b0000, Image Size: 0x2e000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\msctf.dll	SUCCESS	=
Image Base: 0x7fefed40000, Image Size: 0x109000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\nvinitx.dll	SUCCES=
S	Image Base: 0x7fefd5f0000, Image Size: 0x31000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\version.dll	SUCCES=
S	Image Base: 0x7fefd5e0000, Image Size: 0xc000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\advapi32.dll	SUCCE=
SS	Image Base: 0x7fefec50000, Image Size: 0xdb000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\sechost.dll	SUCCES=
S	Image Base: 0x7fefee50000, Image Size: 0x1f000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCESS=
	Image Base: 0x7feff6b0000, Image Size: 0x12d000
> 8:57:20.8	git.exe	12744	Process Create	C:\Program Files\Git\bin\git.exe	S=
UCCESS	PID: 12756, Command line: git.exe  --version
> 8:57:20.8	git.exe	12756	Process Start		SUCCESS	"Parent PID: 12744, Comman=
d line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, E=
nvironment:=20
> 8:57:20.8	git.exe	12756	Thread Create		SUCCESS	Thread ID: 12760
>=20
> This repeats 385 times (I removed the Load Image lines):
>=20
> 8:57:20.9	git.exe	12756	Process Create	C:\Program Files\Git\bin\git.exe	S=
UCCESS	PID: 12764, Command line: git.exe  --version
> 8:57:20.9	git.exe	12764	Process Start		SUCCESS	"Parent PID: 12756, Comman=
d line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, E=
nvironment:=20
> 8:57:20.9	git.exe	12764	Thread Create		SUCCESS	Thread ID: 12768
> 8:57:20.9	git.exe	12764	Process Create	C:\Program Files\Git\bin\git.exe	S=
UCCESS	PID: 12772, Command line: git.exe  --version
> 8:57:20.9	git.exe	12772	Process Start		SUCCESS	"Parent PID: 12764, Comman=
d line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, E=
nvironment:=20
> 8:57:20.9	git.exe	12772	Thread Create		SUCCESS	Thread ID: 12776
> 8:57:21.0	git.exe	12772	Process Create	C:\Program Files\Git\bin\git.exe	S=
UCCESS	PID: 12780, Command line: git.exe  --version
> 8:57:21.0	git.exe	12780	Process Start		SUCCESS	"Parent PID: 12772, Comman=
d line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, E=
nvironment:=20
> 8:57:21.0	git.exe	12780	Thread Create		SUCCESS	Thread ID: 12784
> 8:57:21.0	git.exe	12780	Process Create	C:\Program Files\Git\bin\git.exe	S=
UCCESS	PID: 12788, Command line: git.exe  --version
> 8:57:21.0	git.exe	12788	Process Start		SUCCESS	"Parent PID: 12780, Comman=
d line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, E=
nvironment:=20
> 8:57:21.0	git.exe	12788	Thread Create		SUCCESS	Thread ID: 12792
> ...
>=20
> After that the processes exit one by one (all with error code 1) in rever=
se order:
>=20
> ...
> 8:57:48.6	git.exe	12788	Thread Exit		SUCCESS	Thread ID: 12792, User Time:=
 0.0000000, Kernel Time: 0.0312002
> 8:57:48.6	git.exe	12788	Process Exit		SUCCESS	Exit Status: 1, User Time: =
0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,576,960=
, Peak Private Bytes: 1,654,784, Working Set: 4,235,264, Peak Working Set: =
4,272,128
> 8:57:48.6	git.exe	12780	Thread Exit		SUCCESS	Thread ID: 12784, User Time:=
 0.0000000, Kernel Time: 0.0312002
> 8:57:48.6	git.exe	12780	Process Exit		SUCCESS	Exit Status: 1, User Time: =
0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,597,440=
, Peak Private Bytes: 1,654,784, Working Set: 4,251,648, Peak Working Set: =
4,288,512
> 8:57:48.6	git.exe	12772	Thread Exit		SUCCESS	Thread ID: 12776, User Time:=
 0.0000000, Kernel Time: 0.0312002
> 8:57:48.6	git.exe	12772	Process Exit		SUCCESS	Exit Status: 1, User Time: =
0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,601,536=
, Peak Private Bytes: 1,642,496, Working Set: 4,304,896, Peak Working Set: =
4,341,760
> 8:57:48.6	git.exe	12764	Thread Exit		SUCCESS	Thread ID: 12768, User Time:=
 0.0156001, Kernel Time: 0.0312002
> 8:57:48.6	git.exe	12764	Process Exit		SUCCESS	Exit Status: 1, User Time: =
0.0156001 seconds, Kernel Time: 0.0468003 seconds, Private Bytes: 1,597,440=
, Peak Private Bytes: 1,638,400, Working Set: 4,263,936, Peak Working Set: =
4,300,800
> 8:57:48.6	git.exe	12756	Thread Exit		SUCCESS	Thread ID: 12760, User Time:=
 0.0000000, Kernel Time: 0.0156001
> 8:57:48.6	git.exe	12756	Process Exit		SUCCESS	Exit Status: 1, User Time: =
0.0000000 seconds, Kernel Time: 0.0156001 seconds, Private Bytes: 1,581,056=
, Peak Private Bytes: 1,642,496, Working Set: 4,222,976, Peak Working Set: =
4,259,840
> 8:57:48.6	git.exe	12744	Thread Exit		SUCCESS	Thread ID: 12748, User Time:=
 0.0000000, Kernel Time: 0.0312002
> 8:57:48.6	git.exe	12744	Process Exit		SUCCESS	Exit Status: 1, User Time: =
0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,560,576=
, Peak Private Bytes: 1,650,688, Working Set: 4,231,168, Peak Working Set: =
4,308,992
>=20
> ----------------------------------------------------------------------
> ------ I never saw that before, it seems every command is doing that=20
> (tried status, log, init, fetch).
> It happened to me before that GitExtensions or Visual Studio would spawn =
a lot of git processes, but nothing like this.
> I'm wondering if there is a glitch in the code that would allow git.exe t=
o call itself with same arguments, leading to an (quasi) endless loop of ca=
lls.
> Let me know what I can do to help isolating the problem, I'll assist if p=
ossible.
>=20
> ----------------------------------------------------------------------
> ------ For reference, here is what the built-in git --version is doing=20
> from git bash, only two processes are spawned, git --version first (the c=
ommand line), then git rev-parse, and then the process exits:
>=20
> 9:55:51.2	git.exe	5604	Process Start		SUCCESS	"Parent PID: 752, Command l=
ine: ""C:\Program Files\Git\mingw64\bin\git.exe"" --version, Current direct=
ory: C:\Users\gpierre\, Environment:=20
> ;	ACLOCAL_PATH=3DC:\Program Files\Git\mingw64\share\aclocal;C:\Program Fi=
les\Git\usr\share\aclocal
> ;	ALLUSERSPROFILE=3DC:\ProgramData
> ;	APPDATA=3DC:\Users\gpierre\AppData\Roaming
> ;	COMMONPROGRAMFILES=3DC:\Program Files\Common Files
> ;	COMPUTERNAME=3D
> ;	COMSPEC=3DC:\windows\system32\cmd.exe
> ;	CONFIG_SITE=3DC:/Program Files/Git/mingw64/etc/config.site
> ;	CommonProgramFiles(x86)=3DC:\Program Files (x86)\Common Files
> ;	CommonProgramW6432=3DC:\Program Files\Common Files
> ;	DEFLOGDIR=3DC:\ProgramData\McAfee\Endpoint Security\Logs
> ;	DISPLAY=3Dneeds-to-be-defined
> ;	EXEPATH=3DC:\Program Files\Git
> ;	FP_NO_HOST_CHECK=3DNO
> ;	GTK_BASEPATH=3DC:\Program Files (x86)\GtkSharp\2.12\
> ;	HOME=3DC:\Users\gpierre
> ;	HOMEDRIVE=3DC:
> ;	HOMEPATH=3D\Users\gpierre
> ;	HOSTNAME=3D
> ;	HasSCCM2012Client=3D1
> ;	INFOPATH=3DC:\Program Files\Git\usr\local\info;C:\Program Files\Git\usr=
\share\info;C:\Program Files\Git\usr\info;C:\Program Files\Git\share\info
> ;	LANG=3Den_US.UTF-8
> ;	LOCALAPPDATA=3DC:\Users\gpierre\AppData\Local
> ;	LOGONSERVER=3D\\
> ;	MANPATH=3DC:\Program Files\Git\mingw64\local\man;C:\Program Files\Git\m=
ingw64\share\man;C:\Program Files\Git\usr\local\man;C:\Program Files\Git\us=
r\share\man;C:\Program Files\Git\usr\man;C:\Program Files\Git\share\man
> ;	MINGW_CHOST=3Dx86_64-w64-mingw32
> ;	MINGW_PACKAGE_PREFIX=3Dmingw-w64-x86_64
> ;	MINGW_PREFIX=3DC:/Program Files/Git/mingw64
> ;	MSYSTEM=3DMINGW64
> ;	MSYSTEM_CARCH=3Dx86_64
> ;	MSYSTEM_CHOST=3Dx86_64-w64-mingw32
> ;	MSYSTEM_PREFIX=3DC:/Program Files/Git/mingw64
> ;	NUMBER_OF_PROCESSORS=3D4
> ;	ORIGINAL_PATH=3DC:\Program Files\Git\mingw64\bin;C:\Program Files\Git\u=
sr\bin;C:\Users\gpierre\bin;C:\ProgramData\Oracle\Java\javapath;C:\windows\=
system32;C:\windows;C:\windows\System32\Wbem;C:\windows\System32\WindowsPow=
erShell\v1.0;C:\Program Files\Dell\Dell Data Protection\Encryption;C:\Progr=
am Files (x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft S=
QL Server\130\Tools\Binn;C:\Program Files\dotnet;C:\Program Files (x86)\Gtk=
Sharp\2.12\bin;C:\Users\gpierre\.dnx\bin;C:\Program Files\Microsoft DNX\Dnv=
m;C:\EASE\APEX12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\default\DEOS;C:\P=
rogram Files\PuTTY;C:\windows\System32\WindowsPowerShell\v1.0;C:\windows\Sy=
stem32\WindowsPowerShell\v1.0;C:\Program Files\1E\NomadBranch;C:\HashiCorp\=
Vagrant\bin;C:\windows\System32\WindowsPowerShell\v1.0
> ;	ORIGINAL_TEMP=3DC:/Users/gpierre/AppData/Local/Temp
> ;	ORIGINAL_TMP=3DC:/Users/gpierre/AppData/Local/Temp
> ;	OS=3DWindows_NT
> ;	PATH=3DC:\Users\gpierre\bin;C:\Program Files\Git\mingw64\bin;C:\Program=
 Files\Git\usr\local\bin;C:\Program Files\Git\usr\bin;C:\Program Files\Git\=
usr\bin;C:\Program Files\Git\mingw64\bin;C:\Program Files\Git\usr\bin;C:\Us=
ers\gpierre\bin;C:\ProgramData\Oracle\Java\javapath;C:\windows\system32;C:\=
windows;C:\windows\System32\Wbem;C:\windows\System32\WindowsPowerShell\v1.0=
;C:\Program Files\Dell\Dell Data Protection\Encryption;C:\Program Files (x8=
6)\NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft SQL Server\13=
0\Tools\Binn;C:\Program Files\dotnet;C:\Program Files (x86)\GtkSharp\2.12\b=
in;C:\Users\gpierre\.dnx\bin;C:\Program Files\Microsoft DNX\Dnvm;C:\EASE\AP=
EX12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\default\DEOS;C:\Program Files=
\PuTTY;C:\windows\System32\WindowsPowerShell\v1.0;C:\windows\System32\Windo=
wsPowerShell\v1.0;C:\Program Files\1E\NomadBranch;C:\HashiCorp\Vagrant\bin;=
C:\windows\System32\WindowsPowerShell\v1.0;C:\Program Files\Git\usr\bin\ven=
dor_perl;C:\Program Files\Git\usr\bin\core_perl
> ;	PATHEXT=3D.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
> ;	PKG_CONFIG_PATH=3DC:\Program Files\Git\mingw64\lib\pkgconfig;C:\Program=
 Files\Git\mingw64\share\pkgconfig
> ;	PLINK_PROTOCOL=3Dssh
> ;	PROCESSOR_ARCHITECTURE=3DAMD64
> ;	PROCESSOR_IDENTIFIER=3DIntel64 Family 6 Model 94 Stepping 3, GenuineInt=
el
> ;"
> 9:55:51.2	git.exe	5604	Thread Create		SUCCESS	Thread ID: 8844
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\git.ex=
e	SUCCESS	Image Base: 0x1160000, Image Size: 0x2f0000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\ntdll.dll	SUCCESS	I=
mage Base: 0x77250000, Image Size: 0x19f000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\kernel32.dll	SUCCES=
S	Image Base: 0x77130000, Image Size: 0x11f000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\KernelBase.dll	SUCC=
ESS	Image Base: 0x7fefcde0000, Image Size: 0x6a000
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libico=
nv-2.dll	SUCCESS	Image Base: 0x66000000, Image Size: 0x10b000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\msvcrt.dll	SUCCESS	=
Image Base: 0x7fefd950000, Image Size: 0x9f000
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libint=
l-8.dll	SUCCESS	Image Base: 0x61cc0000, Image Size: 0x28000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\advapi32.dll	SUCCES=
S	Image Base: 0x7fefd7d0000, Image Size: 0xdb000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\sechost.dll	SUCCESS=
	Image Base: 0x7feff520000, Image Size: 0x1f000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCESS	=
Image Base: 0x7fefebf0000, Image Size: 0x12d000
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libpcr=
e2-8-0.dll	SUCCESS	Image Base: 0x64380000, Image Size: 0x54000
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\zlib1.=
dll	SUCCESS	Image Base: 0x62e80000, Image Size: 0x1f000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\user32.dll	SUCCESS	=
Image Base: 0x77030000, Image Size: 0xfa000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\gdi32.dll	SUCCESS	I=
mage Base: 0x7fefd6c0000, Image Size: 0x67000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	Ima=
ge Base: 0x7fefd290000, Image Size: 0xe000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\usp10.dll	SUCCESS	I=
mage Base: 0x7fefd5f0000, Image Size: 0xcb000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\ws2_32.dll	SUCCESS	=
Image Base: 0x7fefd240000, Image Size: 0x4d000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\nsi.dll	SUCCESS	Ima=
ge Base: 0x7fefed50000, Image Size: 0x8000
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libssp=
-0.dll	SUCCESS	Image Base: 0x68ac0000, Image Size: 0xe000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\imm32.dll	SUCCESS	I=
mage Base: 0x7fefed20000, Image Size: 0x2e000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\msctf.dll	SUCCESS	I=
mage Base: 0x7feff410000, Image Size: 0x109000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\nvinitx.dll	SUCCESS=
	Image Base: 0x7fefccd0000, Image Size: 0x31000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\version.dll	SUCCESS=
	Image Base: 0x7fefccc0000, Image Size: 0xc000
> 9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\cryptsp.dll	SUCCESS=
	Image Base: 0x7fefc530000, Image Size: 0x18000
> 9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\rsaenh.dll	SUCCESS	=
Image Base: 0x7fefc230000, Image Size: 0x47000
> 9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\cryptbase.dll	SUCCE=
SS	Image Base: 0x7fefcbf0000, Image Size: 0xf000
> 9:55:51.3	git.exe	5604	Thread Exit		SUCCESS	Thread ID: 8844, User Time: 0=
.0000000, Kernel Time: 0.0468003
> 9:55:51.3	git.exe	5604	Process Exit		SUCCESS	Exit Status: 0, User Time: 0=
.0000000 seconds, Kernel Time: 0.0468003 seconds, Private Bytes: 2,940,928,=
 Peak Private Bytes: 2,981,888, Working Set: 4,980,736, Peak Working Set: 4=
,980,736
> 9:55:51.6	git.exe	5560	Process Start		SUCCESS	"Parent PID: 9080, Command =
line: ""C:\Program Files\Git\mingw64\bin\git.exe"" rev-parse --git-dir --is=
-inside-git-dir --is-bare-repository --is-inside-work-tree --short HEAD, Cu=
rrent directory: C:\Users\gpierre\, Environment:=20
> 9:55:51.6	git.exe	5560	Thread Create		SUCCESS	Thread ID: 5248
> 9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\git.ex=
e	SUCCESS	Image Base: 0x190000, Image Size: 0x2f0000
> 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\ntdll.dll	SUCCESS	I=
mage Base: 0x77250000, Image Size: 0x19f000
> 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\kernel32.dll	SUCCES=
S	Image Base: 0x77130000, Image Size: 0x11f000
> 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\KernelBase.dll	SUCC=
ESS	Image Base: 0x7fefcde0000, Image Size: 0x6a000
> 9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libico=
nv-2.dll	SUCCESS	Image Base: 0x66000000, Image Size: 0x10b000
> 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\msvcrt.dll	SUCCESS	=
Image Base: 0x7fefd950000, Image Size: 0x9f000
> 9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libint=
l-8.dll	SUCCESS	Image Base: 0x61cc0000, Image Size: 0x28000
> 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\advapi32.dll	SUCCES=
S	Image Base: 0x7fefd7d0000, Image Size: 0xdb000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\sechost.dll	SUCCESS=
	Image Base: 0x7feff520000, Image Size: 0x1f000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCESS	=
Image Base: 0x7fefebf0000, Image Size: 0x12d000
> 9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libpcr=
e2-8-0.dll	SUCCESS	Image Base: 0x64380000, Image Size: 0x54000
> 9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\zlib1.=
dll	SUCCESS	Image Base: 0x62e80000, Image Size: 0x1f000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\user32.dll	SUCCESS	=
Image Base: 0x77030000, Image Size: 0xfa000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\gdi32.dll	SUCCESS	I=
mage Base: 0x7fefd6c0000, Image Size: 0x67000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	Ima=
ge Base: 0x7fefd290000, Image Size: 0xe000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\usp10.dll	SUCCESS	I=
mage Base: 0x7fefd5f0000, Image Size: 0xcb000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\ws2_32.dll	SUCCESS	=
Image Base: 0x7fefd240000, Image Size: 0x4d000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\nsi.dll	SUCCESS	Ima=
ge Base: 0x7fefed50000, Image Size: 0x8000
> 9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libssp=
-0.dll	SUCCESS	Image Base: 0x68ac0000, Image Size: 0xe000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\imm32.dll	SUCCESS	I=
mage Base: 0x7fefed20000, Image Size: 0x2e000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\msctf.dll	SUCCESS	I=
mage Base: 0x7feff410000, Image Size: 0x109000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\nvinitx.dll	SUCCESS=
	Image Base: 0x7fefccd0000, Image Size: 0x31000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\version.dll	SUCCESS=
	Image Base: 0x7fefccc0000, Image Size: 0xc000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\cryptsp.dll	SUCCESS=
	Image Base: 0x7fefc530000, Image Size: 0x18000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\rsaenh.dll	SUCCESS	=
Image Base: 0x7fefc230000, Image Size: 0x47000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\cryptbase.dll	SUCCE=
SS	Image Base: 0x7fefcbf0000, Image Size: 0xf000
> 9:55:51.7	git.exe	5560	Thread Exit		SUCCESS	Thread ID: 5248, User Time: 0=
.0000000, Kernel Time: 0.0780005
> 9:55:51.7	git.exe	5560	Process Exit		SUCCESS	Exit Status: 128, User Time:=
 0.0000000 seconds, Kernel Time: 0.0780005 seconds, Private Bytes: 2,932,73=
6, Peak Private Bytes: 2,973,696, Working Set: 5,062,656, Peak Working Set:=
 5,062,656
>=20
>=20
> Thanks a lot! Cheers,
> Pierre G.
>=20
>=20
